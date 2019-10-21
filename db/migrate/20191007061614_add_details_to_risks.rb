class AddDetailsToRisks < ActiveRecord::Migration[5.2]
  def change
    add_column :risks, :description, :text
    add_column :risks, :status, :boolean
    add_column :risks, :probability, :float
    add_column :risks, :impact, :text
  end
end
