class AddMoreDetailsToRisks < ActiveRecord::Migration[5.2]
  def change
    add_column :risks, :action_plan_name, :string
    add_column :risks, :action_plan_description, :text
    add_column :risks, :first_date, :date
    add_column :risks, :last_date, :date
    add_column :risks, :automatic, :boolean
  end
end
