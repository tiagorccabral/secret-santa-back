module V1
  class GamesController < ApiController
    before_action :authorized
    before_action :is_admin?, only: [:create]

    def index
      @games = Game.all.order(:created_at)
      render json: {data: @games}, status: :accepted
    end

    def create

    end
  end
end