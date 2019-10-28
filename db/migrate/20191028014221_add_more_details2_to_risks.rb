class AddMoreDetails2ToRisks < ActiveRecord::Migration[5.2]
  def change
    add_column :risks, :incharge_id, :integer
    add_column :risks, :user_story_id, :integer
  end
end
