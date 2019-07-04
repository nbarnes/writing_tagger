class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :entries
  has_many :projects, foreign_key: "owner_id"
  validates :email, uniqueness: true

  def member_entries
    Entry.joins({:projects => :users}).where(:users => {id: id}).distinct(:entries => :id)
  end

end
