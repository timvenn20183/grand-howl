class AddTelToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :tel, :string
  end
end
