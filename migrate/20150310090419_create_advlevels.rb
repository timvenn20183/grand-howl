class CreateAdvlevels < ActiveRecord::Migration
  def change
    create_table :advlevels do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
