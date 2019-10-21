class RemoveColumnsFromRiskRules < ActiveRecord::Migration[5.2]
  def change
    remove_column :risk_rules, :status, :boolean
    remove_column :risk_rules, :notifications, :boolean
  end
end
