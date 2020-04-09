class RemoveColumnsFromCreature < ActiveRecord::Migration[6.0]
  def change

    remove_column :creatures, :start_time, :integer

    remove_column :creatures, :end_time, :integer
  end
end
