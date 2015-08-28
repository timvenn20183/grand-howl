class AddAppNameToAdvancement < ActiveRecord::Migration
  def change
    add_column :advancements, :app_name, :string
  end
end
