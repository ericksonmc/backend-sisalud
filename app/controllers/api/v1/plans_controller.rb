class Api::V1::PlansController < ApplicationController
  def index
    render json: Plans.all
  end

  def update
    @plan.update(plan_params)
      render json: { message: 'Plan actualizado con exito', status: 'ok' }
    else
      render json: { message: 'Ocurrio un erro al actualizar el plan',
                     erros: @plan.errors.messages , status: 'fail' }, status: 400 and return
    end
  end

  private

  def plan_params
    params.permit(:coverage, :payment_fee, :title, :product_id, coverage_items: {})
  end

  def find_plan
    @plan = Plan.find_by(id: params[:id])
  end
end
