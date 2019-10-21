class AddProjectToRiskRules < ActiveRecord::Migration[5.2]
  def change
    add_reference :risk_rules, :project, foreign_key: true
  end
end
