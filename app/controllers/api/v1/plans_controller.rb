# frozen_string_literal: true

module Api
  module V1
    class PlansController < ApiController
      before_action :find_plan, only: [:show, :update]
      def index
        conditions = { own: false }
        conditions[:own] = [true, false] if current_user.admin? || current_user.super_admin?

        @plans = Plan.where(conditions).order(:id)

        respond_to do |format|
          format.json
        end
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
      rescue Exception => e
        render json: { message: 'Error al crear el plan', errors: e.message }, status: 400
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
      rescue Exception => e
        render json: { message: 'Error al crear el plan', errors: e.message }, status: 400
      end

      private

      def plan_params
        params.permit(:age_limit, :age_min, :coverage, :own, :payment_fee, :product_id, :title,
                      coverage_items_plans_attributes: [:id, :coverage, :waiting_period,
                                                        :coverage_item_id, :plan_id])
      end

      def find_plan
        @plan = Plan.find_by(id: params[:id])
      end
    end
  end
end
