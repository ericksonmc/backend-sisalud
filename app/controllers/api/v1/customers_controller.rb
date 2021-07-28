# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApiController
      before_action :find_customer, only: [:create]

      def index; end

      def show
        render json: @customer, methods: [:agreement]
      end

      def create
        @form = CustomerForm.new(args: customer_params, step: params_step, user: current_user)

        if @form.save!
          render json: @form.customer
        else
          render json: { message: 'Ocurrio Un problema', errors: @form.errors.messages }, status: 400 and return
        end
      end

      private

      def customer_params
        params.require(:customer).permit(:activity, :address, :age, :birthday, :coverage, :coverage_reference,
                      :customer_code, :diagnosis, :dni, :email, :firstname, :is_insured, :last_name,
                      :legal_representative, :main, :parent_id, :phone, :plan_id, :second_name,
                      :secondary_phone, :sex, :size)
      end

      def agreement_params
        params.permit(:diagnosis)
      end

      def params_step
        params.require(:customer).permit(:step).to_s
      end

      def find_customer
        return @customer = Customer.find_by(id: params[:id]) if params[:id].present?

        @customer = Customer.new(customer_params)
      end
    end
  end
end
