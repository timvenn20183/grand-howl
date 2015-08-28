class AddDescriptionToAdvancement < ActiveRecord::Migration
  def change
    add_column :advancements, :description, :text,  :limit => 16777215
  end
end
