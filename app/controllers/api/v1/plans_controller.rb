
module Api
  module V1
    class PlansController < ApiController
      before_action :find_plan, only: [:show, :update]
      def index
        render json: Plan.all
      end

      def show
        render json: @plan
      end

      def create
        @plan = Plan.new(plan_params)
        if @plan.save!
          render json: { message: 'Plan creado con exito', status: 'ok'}
        else
          render json: { message: 'Ocurrio un erro al crear el plan',
            erros: @plan.errors.messages , status: 'fail' }, status: 400 and return
        end
      end

      def update
        if @plan.update(plan_params)
          render json: { message: 'Plan actualizado con exito', status: 'ok' }
        else
          render json: { message: 'Ocurrio un erro al actualizar el plan',
                        erros: @plan.errors.messages , status: 'fail' }, status: 400 and return
        end
      end

      private

      def plan_params
        params.permit(:coverage, :payment_fee, :title, :product_id, coverage_items: [:title, :value, :pe])
      end

      def find_plan
        @plan = Plan.find_by(id: params[:id])
      end
    end
  end
end
