# frozen_string_literal: true

module Api
  module V1
    class EventualitiesController < ApiController
      def index
        condition = {}
        condition[:date] = params[:date].present? ? params[:date].to_time.all_day : Time.now.all_day
        condition[:agreement_id] = agreement_ids if agreement_ids.present?

        @eventualities = Eventuality.where(condition)
      end

      def create
        @form = EventualityForm.new(args: eventuality_params)

        if @form.save; render json: { message: 'Eventualidad creada con exito',
                                      data: @form }, status: 200 and return; end

        render json: { message: 'Ocurrio un error al crear el item',
                       erros: @form.errors.messages,
                       status: 'fail' }, status: 400 and return
      end

      def show
        @eventuality = eventuality
      end

      def update
        @form = EventualityForm.new(args: eventuality_params,
                                    eventuality: eventuality,
                                    state_change: state_change_params).save!

        render json: { message: 'Eventualidad actualizada con exito', data: @form }
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

      def agreement_ids
        if current_user.role == 'admin' || current_user.role == 'assistant' || current_user.role == 'super_admin'
          if params[:user_id].present?
            Agreement.where(user_id: params[:user_id]).ids
          else
            []
          end
        else
          current_user.agreements.ids
        end
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
