module V1
  class SessionsController < ApiController
    skip_before_action :authorized, only: [:create]

    def create
      @user = User.find_by_except_password(user_login_params[:email])
      if @user && @user.authenticate(user_login_params[:password])
        token = encode_token({user_id: @user.id})
        render json: {user: @user, jwt: token},
               except: [:password_digest],
               status: :accepted
      else
        render json: {message: 'Email ou senha inválidos'},
               status: :unauthorized
      end
    end

    private

    def user_login_params
      params.require(:user).permit(:email, :password)
    end
  end
end