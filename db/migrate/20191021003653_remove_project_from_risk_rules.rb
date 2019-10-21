class RemoveProjectFromRiskRules < ActiveRecord::Migration[5.2]
  def change
    remove_reference :risk_rules, :project, foreign_key: true
  end
end
