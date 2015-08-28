class AddRequirementsToBadge < ActiveRecord::Migration
  def change
    add_column :badges, :requirements, :text, :limit => 16777215
  end
end
