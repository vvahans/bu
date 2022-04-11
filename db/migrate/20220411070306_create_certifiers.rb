class CreateCertifiers < ActiveRecord::Migration[7.0]
  def change
    create_table :certifiers do |t|
      t.string :name
      t.string :email
      t.string :locale

      t.timestamps
    end
  end
end
