class Entry < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :project_entries
  has_many :projects, through: :project_entries
  acts_as_taggable
  pg_search_scope :search_for, against: %i(title description content)
end
