# frozen_string_literal: true

module Api
  module V1
    class EventualitiesController < ApiController
      def index
        date = params[:date].to_time

        render json: Eventuality.all and return if current_user.admin? || current_user.assitant?

        render json: Eventuality.where(agreement_id: current_user.agreements.ids)
      end

      def create
        @form = EventualityForm.new(args: eventuality_params)

        if @form.save
          render json: { message: 'Eventualidad creada con exito',
                         data: @form.eventuality }, status: 200 and return
        else
          render json: { message: 'Ocurrio un error al crear el item',
                         erros: @form.errors.messages,
                         status: 'fail' }, status: 400 and return
        end
      end

      def update
        @form = EventualityForm.new(args: eventuality_params,
                                    eventuality: eventuality,
                                    state_change: state_change_params).save!

        render json: { message: 'Eventualidad actualizada con exito', data: @form.eventuality }
      rescue Exception => e
        render json: { message: e }, status: 400 and return
      end

      private

      def eventuality_params
        params.permit(
          :event_type,
          :observations,
          :password,
          :agreement_id,
          :customer_id,
          :date,
          eventuality_expenses_attributes: [:id, :amount, :eventuality_id, :scale_id]
        )
      end

      def state_change_params
        params.permit(:state_change)
      end

      def eventuality
        @eventuality ||= Eventuality.find(params[:id])
      end
    end
  end
end
