class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image
      t.string :slug

      t.timestamps null: false
    end
  end
end
