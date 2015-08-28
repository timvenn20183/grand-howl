class AddAdvlevelToAdvancement < ActiveRecord::Migration
  def change
    add_column :advancements, :advlevel_id, :integer
  end
end
