# frozen_string_literal: true

module Api
  module V1
    class DiseasesController < ApiController
      def index
        render json: Disease.all
      end
    end
  end
end
