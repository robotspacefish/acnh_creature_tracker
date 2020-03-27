class CreatePrice < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.string :amount
      t.belongs_to :creature
    end
  end
end
