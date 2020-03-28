class User < ApplicationRecord
  has_many :creatures_users
  has_many :creatures, through: :creatures_users
end
