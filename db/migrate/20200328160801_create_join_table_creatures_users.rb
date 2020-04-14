class CreateJoinTableCreaturesUsers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :creatures, :users do |t|
      # t.index [:creature_id, :user_id]
      # t.index [:user_id, :creature_id]
    end
  end
end
