class AddImportReferenceToRider < ActiveRecord::Migration[7.0]
  def change
    add_reference :riders, :import, foreign_key: true
  end
end
