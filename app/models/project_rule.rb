class ProjectRule < ApplicationRecord
  belongs_to :project
  belongs_to :risk_rule
end
