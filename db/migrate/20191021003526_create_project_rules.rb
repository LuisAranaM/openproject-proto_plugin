class CreateProjectRules < ActiveRecord::Migration[5.2]
  def change
    create_table :project_rules do |t|
      t.references :project, foreign_key: true
      t.references :risk_rule, foreign_key: true

      t.timestamps
    end
  end
end
