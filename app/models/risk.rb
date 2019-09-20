class Risk < ApplicationRecord
  validates :name, uniqueness: true, length: { minimum: 5 }
end
