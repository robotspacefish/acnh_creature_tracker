class CreateCreaturesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :creatures_users do |t|
      t.belongs_to :creature
      t.belongs_to :user
    end
  end
end
