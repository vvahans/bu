class Import < ApplicationRecord
  has_one_attached :file
  belongs_to :admin

  scope :not_processed, -> { where(imported_at: nil) }
end
