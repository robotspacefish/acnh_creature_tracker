class CreateCreature < ActiveRecord::Migration[6.0]
  def change
    create_table :creatures do |t|
      t.string :name
      t.string :url
      t.string :image_url
      t.string :c_type
      t.string :shadow_size
      t.string :price
      t.string :location
      t.string :time
      t.integer :start_time
      t.integer :end_time
    end
  end
end
