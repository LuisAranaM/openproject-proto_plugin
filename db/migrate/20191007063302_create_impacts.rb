class CreateImpacts < ActiveRecord::Migration[5.2]
  def change
    create_table :risk_impacts do |t|
      t.string :name
      t.string :value
      t.text :description

      t.timestamps
    end
  end
end
