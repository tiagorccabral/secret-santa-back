module V1
  class UsersController < ApplicationController
    def create
      user = User.create(user_params)
      if user.valid?
        render json: user, status: :created
      else
        render json: {error: 'Falha ao criar usuário', msg: user.errors},
               status: :not_acceptable
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end
  end

end
