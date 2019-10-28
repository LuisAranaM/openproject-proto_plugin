class AddDetailsToActionPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :risk_action_plans, :first_date, :date
    add_column :risk_action_plans, :end_date, :date
  end
end
