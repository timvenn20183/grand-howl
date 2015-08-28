class CreateLsentences < ActiveRecord::Migration
  def change
    create_table :lsentences do |t|
      t.integer :entry_id
      t.integer :program_id
      t.string :comment

      t.timestamps null: false
    end
  end
end
