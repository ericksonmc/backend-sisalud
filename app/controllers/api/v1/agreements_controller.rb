# frozen_string_literal: true

module Api
  module V1
    class AgreementsController < ApiController
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
        @form = CustomerForm.new(args: customer_params, step: step_param, user: current_user,
                                 childs: child_params)
        if @form.save!
          render json: { customer: @form.customer, agreement: @form.customer.agreement }
        else
          render json: { message: 'Ocurrio Un problema', errors: @form.errors.messages },
                 status: 400 and return
        end
      end

      def update
        @form = CustomerForm.new(args: customer_params, customer: customer, step: step_param,
                                 childs: child_params)

        if @form.save!
          render json: { customer: @form.customer, agreement: @form.customer.agreement }
        end
      end

      private

      def find_agreements
        case current_user.role
        when 'admin'
          Agreement.all
        when 'agent'
          Agreement.where(id: current_user.id)
        when 'super_admin'
          Agreement.all
        else
          []
        end
      end

      def customer_params
        params.require(:customer).permit(:activity, :age, :birthday, :coverage,
                                         :coverage_reference, :customer_code, :dni,
                                         :email, :firstname, :is_insured, :last_name,
                                         :legal_representative, :main, :parent_id, :phone, :plan_id,
                                         :second_name, :secondary_phone, :sex, :size,
                                         diagnosis: [:id, :description], address: [:firstLine,
                                                                                   :stateId,
                                                                                   :municipalityId])
      end

      def agreement_params
        params.permit(:diagnosis)
      end

      def child_params
        params.require(:customer).permit(childs: [:firstname, :second_name, :last_name, :dni,
                                                  :birthday,
                                                  :age,
                                                  :sex,
                                                  :size,
                                                  :plan_id,
                                                  :is_insured,
                                                  :customer_code,
                                                  diagnosis: [:id, :description]])
      end

      def step_param
        params[:customer][:step]
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
    end
  end
end
