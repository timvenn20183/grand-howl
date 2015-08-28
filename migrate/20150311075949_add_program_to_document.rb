class AddProgramToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :program_id, :integer
  end
end
