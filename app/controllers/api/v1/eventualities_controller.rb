# frozen_string_literal: true

module Api
  module V1
    class EventualitiesController < ApiController
      def index
        render json: Eventuality.all and return if current_user.admin? || current_user.assitant?

        render json: Eventuality.where(agreement_id: current_user.agreements.ids)
      end

      def create
        @form = EventualityForm.new(args: eventuality_params)

        if @form.save
          render json: { message: 'Eventualidad creada con exito' }, status: 200 and return
        else
          render json: { message: 'Ocurrio un erro al crear el item',
                         erros: @form.errors.messages,
                         status: 'fail' }, status: 400 and return
        end
      end

      private

      def eventuality_params
        params.permit(
          :event_type,
          :observations,
          :password,
          :agreement_id,
          :customer_id
        )
      end
    end
  end
end
