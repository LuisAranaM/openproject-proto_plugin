class CreateMasterRuleParameters < ActiveRecord::Migration[5.2]
  def change
    create_table :master_rule_parameters do |t|
      t.string :name
      t.references :risk_rule, foreign_key: true

      t.timestamps
    end
  end
end
