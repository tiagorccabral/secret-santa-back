class Game < ApplicationRecord
  has_many :user_games
  has_many :users, through: :user_games
  validates_presence_of :title

  def as_json(options = {})
    h = super(options)
    {
        id: id,
        title: title,
        description: description,
        is_active: is_active,
        minimum_cost: minimum_cost,
        created_at: created_at,
        updated_at: updated_at,
        participants: get_game_participants
    }
  end

  def get_game_participants
    users = []
    self.user_games.each do |user|
      user = User.find(user.user_id)
      users << {id: user.id, first_name: user.first_name, last_name: user.last_name}
    end
    users
  end
end
