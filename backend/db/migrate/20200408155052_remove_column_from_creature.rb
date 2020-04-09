class RemoveColumnFromCreature < ActiveRecord::Migration[6.0]
  def change

    remove_column :creatures, :time, :string
  end
end
