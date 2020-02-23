class CreateUserGamesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_games do |t|
      t.belongs_to :game
      t.belongs_to :user
    end
  end
end
