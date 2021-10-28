# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApiController
      before_action :check_filter
      def filter_customer
        @customers = []

        case @filter_type
        when 'name'
          @records = Customer.where("firstname ilike '%#{filter_split[0]}%' or last_name ilike '%#{filter_split[1]}%'")
          @records.each do |b|
            b.is_holder? ? @customers << b : @customers << b.parent
          end
        when 'dni'
          @records = Customer.where("dni ilike '%#{filter}%'")
          if @records.blank?
            @records = Customer.where("dni ilike '%#{filter.split('-')[1]}%'")
          end
          @records.each do |b|
            b.is_holder? ? @customers << b : @customers << b.parent
          end
        else
          []
        end
      end

      private

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
