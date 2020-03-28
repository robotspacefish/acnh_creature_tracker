class User < ApplicationRecord
  has_many :creatures_users
  has_many :creatures, through: :creatures_users

  def fish
    self.creatures.fish
  end

  def bugs
    self.creatures.bugs
  end
end
