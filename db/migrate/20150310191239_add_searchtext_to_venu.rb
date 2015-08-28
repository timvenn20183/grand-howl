class AddSearchtextToVenu < ActiveRecord::Migration
  def change
    add_column :venues, :searchtext, :text,  :limit => 16777215
  end
end
