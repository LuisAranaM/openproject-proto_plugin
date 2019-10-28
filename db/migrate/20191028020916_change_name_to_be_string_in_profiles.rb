class ChangeNameToBeStringInProfiles < ActiveRecord::Migration[5.2]
  def change
    change_column :risks, :probability, :string
  end
end
