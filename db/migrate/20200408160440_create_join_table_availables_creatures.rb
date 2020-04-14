class CreateJoinTableAvailablesCreatures < ActiveRecord::Migration[6.0]
  def change
    create_join_table :availables, :creatures do |t|
      # t.index [:available_id, :creature_id]
      # t.index [:creature_id, :available_id]
    end
  end
end
