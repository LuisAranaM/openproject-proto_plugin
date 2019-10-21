class Risk < ApplicationRecord
  belongs_to :project
  validates :name, uniqueness: true, length: { minimum: 5 }
end
