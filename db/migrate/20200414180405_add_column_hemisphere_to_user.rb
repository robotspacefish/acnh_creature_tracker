class AddColumnHemisphereToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hemisphere, :string
  end
end
