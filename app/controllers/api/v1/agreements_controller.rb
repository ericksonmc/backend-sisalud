# frozen_string_literal: true

module Api
  module V1
    class AgreementsController < ApiController
      include Rails.application.routes.url_helpers
      before_action :agreement, only: [:show]

      def index
        conditions = {}
        conditions[:customer_id] = params[:customer_id] if params[:customer_id].present? 
        @agreements = find_agreements.where(conditions)

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
        @agreement = Agreement.find(params[:id])
        @customer = @agreement.customer
        @form = CustomerForm.new(args: customer_params, customer: @customer, user: user_agreement,
                                 childs: child_params)

        if @form.save!
          render json: { customer: @form.customer,
                         agreement: @form.customer.agreement }, status: 200 and return
        end
      end

      def authorize_agreement
        @agreement = Agreement.find(params[:agreement_id])
        if @agreement.pending? && params[:status] == 'active'
          @agreement.activate!
          render json: @agreement
        else
          render json: { message: 'Hubo un problema al actualizar el registro',
                         errors: @agreement.errors.messages }, status: 400 and return
        end
      end

      private

      def find_agreements
        case current_user.role
        when 'admin'
          Agreement.all
        when 'agent'
          Agreement.where(user_id: current_user.id)
        when 'super_admin'
          Agreement.all
        else
          []
        end
      end

      def customer_params
        params.require(:customer).permit(:activity, :age, :birthday, :coverage, :files,
                                         :coverage_reference, :customer_code, :dni,
                                         :email, :firstname, :id_attachment, :is_insured, :last_name,
                                         :legal_representative, :main, :parent_id, :phone, :plan_id,
                                         :second_name, :secondary_phone, :sex, :size, :weight,
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
                                                  :id_attachment, :is_insured, diagnosis: [:id, :description]])
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
