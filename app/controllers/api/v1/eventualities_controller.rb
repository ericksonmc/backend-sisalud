# frozen_string_literal: true

module Api
  module V1
    class EventualitiesController < ApiController
      include Rails.application.routes.url_helpers
      def index
        filters = set_filters
        @eventualities = load_eventualities(filters)
        @pie_data = char_data
        @scale_consumption = scale_consumption

        respond_to do |format|
          format.json 
          format.xlsx {
            render xlsx: "clientes_#{Time.now.to_i}",
                   template: 'api/v1/eventualities/index.xlsx.axlsx',
                   filename: 'Eventualidades_SIPCA',
                   disposition: 'inline'
          }
        end
      end

      def create
        @form = EventualityForm.new(args: event_params)

        if @form.save; render json: { message: 'Eventualidad creada con exito',
                                      data: @form }, status: 200 and return; end

        render json: { message: 'Ocurrio un error al crear el item',
                       erros: @form.errors.messages,
                       status: 'fail' }, status: 400 and return
      rescue Exception => e
        render json: { message: e }, status: 400 and return
      end

      def show
        @eventuality = eventuality
      end

      def update
        @form = EventualityForm.new(args: event_params,
                                    eventuality: eventuality,
                                    state_change: state_change_params).save!

        render json: { message: 'Eventualidad actualizada con exito', data: @form }
      rescue Exception => e
        render json: { message: e }, status: 400 and return
      end

      def eventuality_invoice
        if eventuality.update!(event_params)
          ActionCable.server.broadcast "uploader_#{current_user.id}_channel",
                                       { url: eventuality.invoice_url_image }

          render json: { message: 'Imagen guardada con exito' }, status: 200 and return
        else
          render json: { message: 'Hubo un problema al guardar la factura',
                         errors: eventuality.errors.messages }, status: 400
        end
      end

      private

      def event_params
        params.permit(
          :event_type,
          :observations,
          :password,
          :agreement_id,
          :customer_id,
          :date,
          :date_to,
          :invoice_image,
          :assessment,
          :indications,
          :recipe,
          eventuality_expenses_attributes: [:id, :amount, :eventuality_id, :scale_id],
          eventuality_expense_manuals_attributes: [:id, :title, :amount, :eventuality_id]
        )
      end

      def set_filters
        filters = {}
        filters[:date] = params[:date_to].present? ? date_range : date_param
        filters[:agreement_id] = agreement_ids if agreement_ids.present?
        filters[:event_type] = params[:event_type] if params[:event_type].present?
        filters[:customer_id] = params[:customer_id].to_i if params[:customer_id].present?
        filters.delete(:date) if filters[:date].nil?
        filters
      end

      def date_range
        return unless event_params[:date_to].present?

        date_from = event_params[:date].to_time.beginning_of_day
        date_to = event_params[:date_to].to_time.end_of_day

        [date_from..date_to]
      end

      def date_param
        return if event_params[:customer_id].present? and !event_params[:date].present?

        event_params[:date].present? ? event_params[:date].to_time.all_day : Time.now.all_day
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
        id = params[:id] || params[:eventuality_id]
        @eventuality ||= Eventuality.find(id)
      end

      def char_data
        Eventuality.select('event_type as label, count(event_type) as value')
                   .where(id: @eventualities.pluck(:id))
                   &.group(:label)
                   &.order(:value)
                   &.map { |event| [pretty_key_event(event.label), event.value] }
      end

      def scale_consumption
        EventualityExpense.select('scale_id, count(scale_id) as scale_count, (select title from '\
                                  'scales where id = eventuality_expenses.scale_id) as title')
                          .where(eventuality_id: @eventualities.pluck(:id))
                          .order(:scale_count).group(:scale_id).map { |i| [i.title, i.scale_count] }
      end

      def load_eventualities(filters)
        events = Eventuality.where(filters)
        events_with_agreements = []
        events.each do |e|
          events_with_agreements.push(e) if e.agreement.present?
        end
        events_with_agreements
      end
    end
  end
end
