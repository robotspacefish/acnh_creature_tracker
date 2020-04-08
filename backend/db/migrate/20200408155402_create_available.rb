class CreateAvailable < ActiveRecord::Migration[6.0]
  def change
    create_table :availables do |t|
      t.string :time
    end
  end
end
