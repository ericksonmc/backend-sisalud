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
          @form = UserForm.new(args: user_params)

          if @form.save!
            render json: { message: 'Usuario creado con exito' }
          else
            render json: { message: 'Hubo un error al crear el usuario',
                           erros: @users.errors.messages }, status: 400
          end
        end

        def show
          render json: user, methods: [:permissions]
        end

        def update
          @form = UserForm.new(args: user_params, user: user)

          if @form.save!
            render json: { message: 'Usuario actualizado con exito' }
          else
            render json: { message: 'Hubo un error al actualizar el usuario',
                           erros: @user.errors.messages }, status: 400
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
