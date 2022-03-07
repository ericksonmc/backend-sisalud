# frozen_string_literal: true

module Api
  module V1
    class AgreementsController < ApiController
      include Rails.application.routes.url_helpers
      before_action :agreement, only: [:show]

      def index
        @agreements = find_agreements

        respond_to do |format|
          format.json
        end
      end

      def show
        respond_to do |format|
          format.json
        end
      end

      def create
        @form = CustomerForm.new(args: customer_params, user: user_agreement,
                                 childs: child_params, signed_date: signed_date)

        if @form.save!
          render json: { customer: @form.customer,
                         agreement: @form.customer.agreement }, status: 200 and return
        else
          render json: { message: 'Ocurrio Un problema',
                         errors: @form.errors.messages }, status: 400 and return
        end
      end

      def update
        @customer = agreement.customer
        @form = CustomerForm.new(args: customer_params, customer: @customer, user: user_agreement,
                                 childs: child_params)

        if @form.save!
          render json: { customer: @form.customer,
                         agreement: @form.customer.agreement }, status: 200 and return
        else
          render json: { message: 'Hubo un problema al actualizar el registro',
                         errors: agreement.errors.messages }, status: 400 and return
        end
      end

      def destroy
        if agreement.to_destroy
          render json: { message: 'Contrato eliminado con exito' }, status: 200 and return
        else
          render json: { message: 'Contrato ya fue eliminado' }, status: 200 and return
        end
      end

      def authorize_agreement
        if agreement.pending? && params[:status] == 'active'
          agreement.activate!
          render json: agreement
        else
          render json: { message: 'Hubo un problema al actualizar el registro',
                         errors: agreement.errors.messages }, status: 400 and return
        end
      end

      def update_agreement
        @form = AgreementForm.new(args: agreement_params, customer: agreement.customer,
                                  user_id: agreement_params[:user_id],
                                  signed_date: agreement_params[:signed_date],
                                  state_change: params[:state_change])
        render json: { message: 'Contrato actualizado con exito' } if @form.save!
      end

      private

      def find_agreements
        conditions = {}
        conditions[:user_id] = params[:user_id] if params[:user_id].present?

        case current_user.role
        when 'admin', 'super_admin'
          Agreement.where(conditions)
        when 'agent'
          Agreement.where(conditions).where(user_id: current_user.id)
        else
          []
        end
      end

      def customer_params
        params.require(:customer).permit(:activity, :age, :birthday, :files,
                                         :coverage_reference, :customer_code, :last_name,
                                         :email, :firstname, :id_attachment, :is_insured, :dni,
                                         :legal_representative, :main, :parent_id, :phone, :plan_id,
                                         :second_name, :secondary_phone, :sex, :size, :weight,
                                         :payment_fee,
                                         diagnosis: [:id, :description],
                                         address: [:first_line, :zip_code,
                                                   state: [:title, :id],
                                                   municipality: [:title, :id]])
      end

      def agreement_params
        params.permit(
          :agreement_number,
          :amount,
          :diagnosis,
          :payment_method,
          :signed_date,
          :user_id
        )
      end

      def child_params
        params.require(:customer).permit(childs: [:age, :birthday, :customer_code, :dni, :files,
                                                  :firstname, :is_insured, :last_name, :plan_id,
                                                  :second_name, :sex, :size, :weight, :id,
                                                  :coverage_reference, :payment_fee,
                                                  :id_attachment, :is_insured, :_destroy,
                                                  diagnosis: [:id, :description]])
      end

      def signed_date
        params[:customer][:signed_date]
      end

      def customer
        @customer ||= Customer.find(params[:customer][:id])
      end

      def agreement
        @agreement ||= Agreement.find(params[:id])
      end

      def main_customer
        @main_customer ||= agreement.customer
      end

      def user_agreement
        if current_user.agent?
          @user_agreement ||= current_user
        else
          User.find_by(id: params[:customer][:user_id])
        end
      end
    end
  end
end
