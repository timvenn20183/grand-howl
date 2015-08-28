class AddChallengeToAdvancement < ActiveRecord::Migration
  def change
    add_column :advancements, :challenge_id, :integer
  end
end
