class ProjectRule < ApplicationRecord
  belongs_to :project
  belongs_to :risk_rule
  has_many :risk_rule_parameters
end
