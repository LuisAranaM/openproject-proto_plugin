class AddColumnsToProjectRules < ActiveRecord::Migration[5.2]
  def change
    add_column :project_rules, :notifications, :boolean
    add_column :project_rules, :status, :boolean
  end
end
