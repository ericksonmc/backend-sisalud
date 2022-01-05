# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApiController
      before_action :check_filter

      def index
        per = params[:per] || 20
        page = params[:page]

        if params[:filter].present?
          @customers = Customer.where("firstname ilike '%#{filter_split[0]}%' "\
                                      "or last_name ilike '%#{filter_split[1]}%'")
        else
          @customers = Customer.all.order(:id)
        end

        per = @customers.count if params[:per] == 'todos'

        @pagination = @customers.page(page).per(per)

        respond_to do |format|
          format.json
          format.xlsx {
            render xlsx: "clientes_#{Time.now.to_i}",
                   template: 'api/v1/customers/index.xlsx.axlsx',
                   filename: "clientes_#{Time.now.to_i}_SIPCA",
                   disposition: 'inline'
          }
        end
      end

      def eventualities
        @eventualities = customer.act_events
        @pie_data = @eventualities&.select('event_type as label, count(event_type) as value')
                                  &.group(:label)
                                  &.order(:value)
                                  &.map { |event| [pretty_key_event(event.label), event.value] }

        respond_to do |format|
          format.json
          format.xlsx {
            render xlsx: "clientes_#{Time.now.to_i}",
                   template: 'api/v1/customers/eventualities.xlsx.axlsx',
                   filename: "cliente_#{customer.full_name}_#{Time.now.to_i}_SIPCA",
                   disposition: 'inline'
          }
        end
      end

      def update
        unless customer.present?
          render json: { message: 'CLiente no encontrado' }, status: 400 and return
        end

        customer_form = SingleCustomerForm.new(args: customer_param, customer: customer)

        render json: { message: 'Cliente actualziado con exito' } if customer_form.save!
      end

      def filter_customer
        @customers = []

        case @filter_type
        when 'name'
          @records = Customer.where("firstname ilike '%#{filter_split[0]}%' "\
                                    "or last_name ilike '%#{filter_split[1]}%'")
          @records.each do |b|
            b.holder? ? @customers << b : @customers << b.parent
          end
        when 'dni'
          @records = Customer.where("dni ilike '%#{filter}%'")
          @records = Customer.where("dni ilike '%#{filter.split('-')[1]}%'") if @records.blank?
          @records.each do |b|
            b.holder? ? @customers << b : @customers << b.parent
          end
        else
          []
        end
      end

      def customer_scales_limit
        render json: scale_quantity
      end

      private

      def customer_param
        params.permit(
          :activity,
          :address,
          :age,
          :birthday,
          :childs,
          :coverage,
          :coverage_reference,
          :customer_code,
          :dni,
          :diagnosis,
          :email,
          :firstname,
          :is_insured,
          :last_name,
          :legal_representative,
          :main,
          :parent_id,
          :phone,
          :payment_fee,
          :plan_id,
          :second_name,
          :secondary_phone,
          :sex,
          :size,
          :weight
        )
      end

      def scale_quantity
        scales.where(id: actual_expenses.pluck(:scale_id).uniq).map do |scale|
          {
            title: scale.title,
            count: actual_expenses.where(scale_id: scale.id).count,
            limit: scale.quantity,
            scale_id: scale.id
          }
        end
      end

      def customer
        customer_id = params[:customer_id] || params[:id]
        @customer ||= Customer.find(customer_id)
      end

      def actual_expenses
        @actual_expenses ||= EventualityExpense.where(eventuality_id: customer.act_events.ids)
      end

      def scales
        @scales ||= Scale.with_limit
      end

      def check_filter
        case filter_type
        when 'name' || 'beneficiarie'
          if filter_split.length < 2
            render json: { message: 'Debe Enviar nombre y apellido' },
                   status: 400 and return
          end
        end
      end

      def filter_type
        @filter_type ||= params[:filter_type]
      end

      def filter
        params[:filter]
      end

      def filter_split
        @filter_split ||= params[:filter].split
      end
    end
  end
end
