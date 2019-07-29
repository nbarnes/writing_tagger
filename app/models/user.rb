class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :entries
  has_many :projects, foreign_key: "owner_id"
  validates :email, uniqueness: true

  # The owner_entries query is more complicated than it would otherwise need to be because it needs to maintain
  # a parallel structure to the member_entries query, else they cannot be or'd together
  def owner_entries
    Entry.joins({:projects => :users}).where(:entries => {user_id: id}).distinct(:entries => :id)
  end

  def member_entries
    Entry.joins({:projects => :users}).where(:users => {id: id}).distinct(:entries => :id)
  end

  def accessible_entries
    owner_entries.or(member_entries)
  end

end
