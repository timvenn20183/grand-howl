class CreateCattypes < ActiveRecord::Migration
  def change
    create_table :cattypes do |t|
      t.string :name
      t.string :slug
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
