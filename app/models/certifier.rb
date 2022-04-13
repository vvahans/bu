class Certifier < ApplicationRecord
  has_many :admins

  validates :name, :email, presence: true
end
