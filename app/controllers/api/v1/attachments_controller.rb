# frozen_string_literal: true

module Api
  module V1
    class AttachmentsController < ApiController
      def create
        attachment = Attachment.new(attachment_params)

        unless attachment.save!
          render json: { message: 'Hubo un problema al guardar los files' },
                 status: 400 and return
        end

        render json: attachment
      end

      private

      def attachment_params
        params.permit(:description, :fileable_type, files: [])
      end
    end
  end
end
