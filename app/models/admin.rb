class Admin < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  belongs_to :certifier
  has_many :imports

  validates :email, presence: true

  def jwt_payload
    super.merge('id' => id)
  end
end
