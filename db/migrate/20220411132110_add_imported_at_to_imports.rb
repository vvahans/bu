class AddImportedAtToImports < ActiveRecord::Migration[7.0]
  def change
    add_column :imports, :imported_at, :datetime
  end
end
