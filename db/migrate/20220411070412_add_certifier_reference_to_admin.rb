class AddCertifierReferenceToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_reference :admins, :certifier, foreign_key: true
  end
end
