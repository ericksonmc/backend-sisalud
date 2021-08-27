# frozen_string_literal: true

module Api
  module V1
    class PlansController < ApiController
      before_action :find_plan, only: [:show, :update]
      def index
        conditions = { own: false }
        conditions[:own] if current_user.admin? || current_user.super_admin?

        render json: Plan.where(conditions).all
      end

      def show
        render json: @plan
      end

      def create
        @form = PlanForm.new(args: plan_params, plan: @plan)

        unless @form.save!
          render json: { message: 'Ocurrio un erro al crear el plan',
                         erros: @form.errors.messages,
                         status: 'fail' }, status: 400 and return
        end

        render json: { message: 'Plan creado con exito', status: 'ok' }
      end

      def update
        @form = PlanForm.new(args: plan_params, plan: @plan)

        unless @form.save!
          render json: { message: 'Ocurrio un erro al actualizar el plan',
                         erros: @form.errors.messages,
                         status: 'fail' },
                 status: 400 and return
        end

        render json: { message: 'Plan actualizado con exito', status: 'ok' }
      end

      private

      def plan_params
        params.permit(:age_limit, :age_min, :coverage, :own, :payment_fee, :product_id, :title,
                      coverage_items: [:title, :value, :pe])
      end

      def find_plan
        @plan = Plan.find_by(id: params[:id])
      end
    end
  end
end
