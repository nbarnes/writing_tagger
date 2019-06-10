class ProjectEntry < ApplicationRecord
  belongs_to :project
  belongs_to :entry

  validates :entry_id, :uniqueness => { :scope => :project_id }
end
