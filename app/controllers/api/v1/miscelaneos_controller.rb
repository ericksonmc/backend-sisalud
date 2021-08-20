# frozen_string_literal: true

module Api
  module V1
    class MiscelaneosController < ApiController
      def states
        render json: State.all
      end

      def municipalities
        render json: Municipality.where(state_id: params[:state_id])
      end

      def sections
        render json: Section.all
      end
    end
  end
end
