class AddMinimumCostAndIsActiveToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :is_active, :boolean, default: true
    add_column :games, :minimum_cost, :float, default: 0.0
  end
end
