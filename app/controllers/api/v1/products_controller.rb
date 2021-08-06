# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      before_action :find_product, only: [:show, :update]
      def index
        render json: Product.all
      end

      def show
        render json: @product
      end

      def update
        unless @product.update(product_params)
          render json: { message: 'Ocurrio un erro al actualizar el producto',
                         erros: @product.errors.messages, status: 'fail' }, status: 400 and return
        end

        render json: { message: 'Producto actualizado con exito', status: 'ok' }
      end

      private

      def product_params
        params.permit(:title, :description)
      end

      def find_product
        @product = Product.find_by(id: params[:id])
      end
    end
  end
end
