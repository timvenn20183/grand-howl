class AddRawToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :raw, :string
  end
end
