class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end
  def show
    @tag = params[:tag]
    @entries = Entry.where(user_id: current_user.id).tagged_with @tag
  end
end
