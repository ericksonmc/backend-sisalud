# frozen_string_literal: true

module Api
  module V1
    class CoverageItemsController < ApiController
      def index
        render json: CoverageItem.all
      end

      def create
        item = CoverageItem.new(coverage_item_params)

        render json: { message: 'Item creado con exito' }, status: 200 and return if item.save!

        render json: { message: 'Item ya existe', erros: item.errors.messages }, status: 400 and return
      end

      def update
        if coverage_item.update(coverage_item_params); render json: { message: 'Item actualizado con exito' },
                                                     status: 200 and return; end

        render json: { message: 'Item ya existe', erros: coverage_item.errors.messages },
               status: 400 and return
      end

      private

      def coverage_item_params
        params.permit(:id, :title, scale_items: [])
      end

      def coverage_item
        @coverage_item ||= CoverageItem.find(coverage_item_params[:id])
      end
    end
  end
end
