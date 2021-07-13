# frozen_string_literal: true

include ActionController::MimeResponds

class Api::V1::ApiController < ActionController::API
  respond_to :json
  before_action :authenticate_user!
end
