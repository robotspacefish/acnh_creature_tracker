class Creature < ApplicationRecord
  has_many :hemispheres

  def self.all_fish
    Creature.where(c_type: "fish")
  end
end