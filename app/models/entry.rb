class Entry < ApplicationRecord
  include PgSearch
  belongs_to :user
  acts_as_taggable
  pg_search_scope :search_for, against: %i(title description content)
end
