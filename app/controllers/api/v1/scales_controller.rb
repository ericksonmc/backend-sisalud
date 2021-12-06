# frozen_string_literal: true

module Api
  module V1
    class ScalesController < ApiController
      before_action :find_scale
      def index
        @scales = Scale.all
      end

      def create
        @form = ScaleForm.new(args: scale_params, scale: @scale)

        unless @form.save!
          render json: { message: 'Ocurrio un erro al crear el item',
                         erros: @form.errors.messages,
                         status: 'fail' }, status: 400 and return
        end

        render json: { message: 'Item creado con exito', status: 'ok' }
      rescue Exception => e
        render json: { message: 'Error al crear el item', errors: e.message }, status: 400
      end

      def update
        @form = ScaleForm.new(args: scale_params, scale: @scale)

        unless @form.save!
          render json: { message: 'Ocurrio un erro al actualizar el item',
                         erros: @form.errors.messages,
                         status: 'fail' },
                 status: 400 and return
        end

        render json: { message: 'Item actualizado con exito', status: 'ok' }
      rescue Exception => e
        render json: { message: 'Error al crear el scale', errors: e.message }, status: 400
      end

      private

      def scale_params
        params.permit(:id, :title, :category, :status, :amount, :quantity)
      end

      def find_scale
        @scale = Scale.find_by(id: params[:id])
      end
    end
  end
end
