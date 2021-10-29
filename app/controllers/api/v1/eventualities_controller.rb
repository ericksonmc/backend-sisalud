# frozen_string_literal: true

module Api
  module V1
    class EventualitiesController < ApiController

      def index; end

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
