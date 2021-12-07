# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.params[:token]
      decoded_token = JWT.decode token, ENV['devise_jwt_secret_key'], true, { :algorithm => 'HS256' }
      if (current_user = User.find(decoded_token[0]['sub']))
        current_user
      else
        reject_unauthorized_connection
      end
    rescue StandartError
      reject_unauthorized_connection
    end
  end
end
