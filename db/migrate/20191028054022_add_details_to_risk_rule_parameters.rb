class AddDetailsToRiskRuleParameters < ActiveRecord::Migration[5.2]
  def change
    add_reference :risk_rule_parameters, :project_rule, foreign_key: true
    add_reference :risk_rule_parameters, :master_rule_parameters, foreign_key: true
  end
end
