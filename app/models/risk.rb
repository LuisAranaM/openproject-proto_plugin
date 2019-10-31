class Risk < ApplicationRecord
  belongs_to :project
  validates :name, length: { minimum: 5 }
end
