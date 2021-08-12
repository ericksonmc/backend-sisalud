# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApiController
      before_action :check_filter
      def filter_customer
        case @filter_type
        when 'name'
          @customers = Customer.where("firstname ilike '%#{filter_split[0]}%' or last_name ilike '%#{filter_split[1]}%'")
        when 'dni'
          @customers = Customer.where("dni ilike '%#{filter}%'")
        when 'beneficiarie'
          beneficiary = Customer.where("firstname ilike '%#{filter_split[0]}%' or last_name ilike '%#{filter_split[1]}%'")
          @customer = beneficiary.parent
        else
          []
        end
      end

      private

      def check_filter
        case filter_type
        when 'name' || 'beneficiarie'
          if filter_split.length < 2
            render json: { message: 'De Enviar nombre y apellido' },
                   status: 400 and return
          end
        end
      end

      def filter_type
        @filter_type ||= params[:filter_type]
      end

      def filter
        @filter ||= params[:filter]
      end

      def filter_split
        @filter_split ||= params[:filter].split
      end
    end
  end
end
