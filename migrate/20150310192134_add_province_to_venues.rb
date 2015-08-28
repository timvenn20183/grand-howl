class AddProvinceToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :province_id, :integer
    add_column :venues, :area, :string
    add_column :venues, :time_from_city, :integer
    add_column :venues, :website, :string
  end
end
