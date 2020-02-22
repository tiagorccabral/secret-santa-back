class ApiController < ApplicationController
    before_action :authorized

    def authorized
        render json: {message: 'Por favor, realize seu login'},
            status: :unauthorized unless logged_in?
    end

    def is_admin?
         render json: {message: 'Ação não permitida'},
             status: :unauthorized unless user_is_admin?
    end

    def logged_in?
        !!current_user
    end

    def user_is_admin?
       !!current_user_is_admin
    end

    def current_user
      if decoded_token()
         user_id = decoded_token[0]['user_id']
         @user = User.find_by(id: user_id)
      end
    end

    # Header token format: 'Authorization': 'Bearer <token>'

    def decoded_token
      if auth_header()
         token = auth_header.split(' ')[1]
         begin
            JWT.decode(token, Rails.application.secrets.secret_key_base, true,
               algorithm: 'HS256')
         rescue JWT::DecodeError
            nil
         end
      end
    end

    private

    def current_user_is_admin
        if decoded_token()
           user_id = decoded_token[0]['user_id']
           @user = User.find_by(id: user_id, is_admin: true)
        end
     end

    def auth_header
      request.headers['Authorization']
    end

    def encode_token(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
end
