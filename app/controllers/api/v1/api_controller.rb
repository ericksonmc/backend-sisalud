# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      include ActionController::MimeResponds

      respond_to :json
      before_action :authenticate_user!
    end
  end
end
