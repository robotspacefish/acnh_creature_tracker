class AddColumnsToAvailables < ActiveRecord::Migration[6.0]
  def change
    add_column :availables, :start_time, :integer
    add_column :availables, :end_time, :integer
  end
end
