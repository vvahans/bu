class Import < ApplicationRecord
  has_one_attached :file
  belongs_to :admin
end
