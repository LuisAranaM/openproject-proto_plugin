class CreateActionPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :risk_action_plans do |t|
      t.string :name
      t.text :description
      t.references :risk, foreign_key: true

      t.timestamps
    end
  end
end
