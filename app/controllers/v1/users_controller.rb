module V1
  class UsersController < ApiController
    skip_before_action :authorized, only: [:create]
    before_action :set_user, only: [:update]

    # GET v1/users
    def index
      @users = User.all
      render json: {data: @users}, except: [:password_digest], status: :accepted
    end

    # POST v1/users
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

    # PATCH/PUT v1/users/1
    def update
      if @user.update(user_params)
        render json: {data: @user}
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end
  end

end
