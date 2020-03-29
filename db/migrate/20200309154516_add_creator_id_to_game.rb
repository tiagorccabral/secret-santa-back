class AddCreatorIdToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :creator_id, :bigint, default: nil
  end
end
