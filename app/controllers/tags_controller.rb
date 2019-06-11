class TagsController < ApplicationController
  def index
    @entries = Entry.where(user_id: current_user.id)
    member_entries = Entry.joins({:projects => :users}).where(:users => {id: current_user.id}).distinct(:entries => :id)
    @entries += member_entries
    @tags = @entries.map do |entry|
      entry.tags
    end
    @tags.flatten!.uniq!
    binding.pry
  end
  def show
    @tag = params[:tag]
    @entries = Entry.where(user_id: current_user.id).tagged_with params[:tag]
    member_entries = Entry.joins({:projects => :users}).where(:users => {id: current_user.id}).distinct(:entries => :id).tagged_with @tag
    @entries += member_entries
    @entries = @entries.uniq
    end
end
