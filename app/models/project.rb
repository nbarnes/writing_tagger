class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :project_users
  has_many :users, through: :project_users
  has_many :project_entries
  has_many :entries, through: :project_entries

  def members
    return users << owner
  end

end
