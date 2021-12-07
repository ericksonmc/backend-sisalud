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

      def types_scale
        render json: [
          { title: 'surgery', value: 0, title_es: 'Cirugia' },
          { title: 'gynecology_and_obstetrics', value: 1, title_es: 'Ginecologia & Obstetricia' },
          { title: 'orl', value: 2, title_es: 'ORL' },
          { title: 'traumatology', value: 3, title_es: 'Traumatologia' },
          { title: 'endoscopy', value: 4, title_es: 'Endoscopia' },
          { title: 'ultrasound', value: 5, title_es: 'Ecografia' },
          { title: 'hospitalization', value: 6, title_es: 'Hospitalizacion' },
          { title: 'consultation', value: 7, title_es: 'Consultas' },
          { title: 'cardiology', value: 8, title_es: 'Cardiologia' },
          { title: 'special_laboratory', value: 9, title_es: 'Laboratorio Especial' },
          { title: 'studies', value: 10, title_es: 'Estudios' },
          { title: 'emergency', value: 11, title_es: 'Emergencia'  },
          { title: 'basic_lab', value: 12, title_es: 'Laboratorio Basico' },
          { title: 'odontology', value: 13, title_es: 'Odontología' },
          { title: 'gynecology', value: 14, title_es: 'Ginecología'}
        ]
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
