class Rider < ApplicationRecord
  belongs_to :import

  has_one_attached :certificate

  def full_name
    "#{first_name} #{last_name}"
  end
end
