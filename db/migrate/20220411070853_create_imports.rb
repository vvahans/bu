class CreateImports < ActiveRecord::Migration[7.0]
  def change
    create_table :imports do |t|
      t.integer :total_records
      t.integer :failed_records

      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
