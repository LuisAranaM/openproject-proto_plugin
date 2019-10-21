class CreateRiskRules < ActiveRecord::Migration[5.2]
  def change
    create_table :risk_rules do |t|
      t.string :name
      t.text :description
      t.boolean :status
      t.boolean :notifications
      t.text :suggested_actions

      t.timestamps
    end
  end
end
