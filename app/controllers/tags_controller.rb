class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  def show
    @tag = params[:tag]
    @entries = Entry.tagged_with @tag
  end
end
