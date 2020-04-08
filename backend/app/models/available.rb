class Available < ApplicationRecord
  has_many :availables_creatures
  has_many :creatures, through: :availables_creatures
end