class AddProjectToRisks < ActiveRecord::Migration[5.2]
  def change
    add_reference :risks, :project, foreign_key: true
  end
end
