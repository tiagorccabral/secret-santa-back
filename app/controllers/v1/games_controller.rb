module V1
  class GamesController < ApiController
    before_action :authorized
    before_action :is_admin?, except: [:index, :show]
    before_action :set_game, only: [:show, :update, :destroy]

    # GET v1/games
    def index
      @games = Game.all.order(:created_at)
      render json: {data: @games}, status: :accepted
    end

    # GET v1/games/1
    def show
      render json: {data: @game}
    end

    # POST v1/games
    def create
      @game = Game.new(game_params)

      if @game.save
        render json: {data: @game}, status: :created
      else
        render json: {error: 'Falha ao novo jogo', msg: @game.errors},
               status: :not_acceptable
      end
    end

    # PATCH/PUT v1/games/1
    def update
      if @game.update(game_params)
        render json: {data: @game}
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end

    # DELETE v1/games/1
    def destroy
      @game.destroy
    end

    private

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:title, :description, :user_ids => [])
    end
  end
end