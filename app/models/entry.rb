class Entry < ApplicationRecord
  include PgSearch
  
  acts_as_taggable
  pg_search_scope :search_for, against: %i(title description content)
end
