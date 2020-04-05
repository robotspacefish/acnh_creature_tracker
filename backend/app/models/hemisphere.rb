class Hemisphere < ApplicationRecord
  belongs_to :creature
  # scope :north, -> { find_by(h_type: "north")}
  # scope :south, -> { find_by(h_type: "south")}
end