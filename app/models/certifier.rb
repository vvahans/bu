class Certifier < ApplicationRecord
  has_many :admins

  validate :name, :email, presence: true
end
