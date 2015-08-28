class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pass
      t.boolean :active, :default => true
      t.integer :level, :default => 0

      t.timestamps null: false
    end
  end
end
