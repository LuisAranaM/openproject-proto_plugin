class CreateRiskRuleParameters < ActiveRecord::Migration[5.2]
  def change
    create_table :risk_rule_parameters do |t|
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
