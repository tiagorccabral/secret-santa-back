module V1
  class UsersController < ApiController
    skip_before_action :authorized, only: [:create]

    def create
      user = User.create(user_params)
      if user.valid?
        @token = encode_token(user_id: user.id)
        render json: {user: user, jwt: @token}, status: :created
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
