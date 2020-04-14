class CreateHemisphere < ActiveRecord::Migration[6.0]
  def change
    create_table :hemispheres do |t|
      t.string :h_type
      t.boolean :january
      t.boolean :february
      t.boolean :march
      t.boolean :april
      t.boolean :may
      t.boolean :june
      t.boolean :july
      t.boolean :august
      t.boolean :september
      t.boolean :october
      t.boolean :november
      t.boolean :december
      t.belongs_to :creature
    end
  end
end
