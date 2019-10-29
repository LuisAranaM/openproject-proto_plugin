class AddDetailsToProjectRule < ActiveRecord::Migration[5.2]
  def change
    add_column :project_rules, :param_1, :string
    add_column :project_rules, :param_2, :string
    add_column :project_rules, :param_3, :string
    add_column :project_rules, :param_4, :string
    add_column :project_rules, :param_5, :string
  end
end
