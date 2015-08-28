class AddAssocsToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :entry_id, :integer
    add_column :documents, :advancement_id, :integer
    add_column :documents, :category_id, :integer
    add_column :documents, :badge_id, :integer
  end
end
