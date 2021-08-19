# frozen_string_literal: true

module Api
  module V1
    module Users
      class UsersController < ApiController
        def index
          condition = {}
          condition[:role] = params[:role] if params[:role].present?

          render json: User.where(condition).all
        end

        def create
          @users = User.new(user_params)

          if @users.save!
            render json: { message: 'Usuario creado con exito' }
          else
            render json: { message: 'Hubo un error al crear el usuario', erros: @users.errors.messages },
                   status: 400
          end
        end

        def update
          if user.update!(user_params)
            render json: { message: 'Usuario actualizado con exito' }
          else
            render json: { message: 'Hubo un error al actualizar el usuario', erros: @user.errors.messages },
                   status: 400
          end
        end

        private

        def user_params
          params.permit(:first_name, :last_name, :email, :password, :role, :active, :agent_code,
                        permissions_attributes: [:id, :section_id, :active])
        end

        def user
          @user ||= User.find(params[:id])
        end
      end
    end
  end
end
