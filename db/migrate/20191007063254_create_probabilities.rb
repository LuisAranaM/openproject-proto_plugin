class CreateProbabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :risk_probabilities do |t|
      t.string :name
      t.float :value
      t.text :description

      t.timestamps
    end
  end
end
