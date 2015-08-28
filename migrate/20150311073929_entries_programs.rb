class EntriesPrograms < ActiveRecord::Migration
  def change
    create_table :entries_programs, :id => false do |t|
      t.references :entry, :program
    end

    add_index :entries_programs, [:entry_id, :program_id],
      name: "entries_programs_index",
      unique: true
  end
end
