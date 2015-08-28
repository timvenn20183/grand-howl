class AddRawToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :raw, :string
  end
end
