class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :message
      t.string :subject
      t.integer :user_id
      t.integer :entry_id

      t.timestamps null: false
    end
  end
end
