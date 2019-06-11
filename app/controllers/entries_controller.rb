class EntriesController < ApplicationController

  # GET /entries
  def index
    @entries = [] and return unless current_user
    @entries = Entry.where(user_id: current_user.id)
    member_entries = Entry.joins({:projects => :users}).where(:users => {id: current_user.id}).distinct(:entries => :id)
    @entries += member_entries
    unless params[:content_search].blank?
      @entries = Entry.search_for params[:content_search]
    end
    unless params[:tag_search].blank?
      terms = params[:tag_search].split(' ')
      @includes = terms.select do |term|
        term.chr != '-'
      end
      @excludes = terms.select do |term|
        term.chr == '-'
      end.map do |term|
        term[1..-1]
      end
      unless @includes.empty?
        @entries = @entries.tagged_with(@includes)
      end
      unless @excludes.empty?
        @entries = @entries.tagged_with(@excludes, exclude: true) 
      end
    end
  end

  # GET /entries/1
  def show
    @entry = Entry.find(params[:id])
    @member_users = User.joins({:projects => :entries}).where(:users => {id: current_user.id}).uniq
    head :unauthorized and return unless (@entry.user == current_user || @member_users.include?(current_user))
  end

  # GET /entries/new
  def new
    redirect_to entries_path, notice: 'You must be logged in to create an entry.' and return unless current_user
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
    head :unauthorized and return unless @entry.user == current_user
  end

  # POST /entries
  def create
    head :unauthorized and return unless current_user
    @entry = Entry.new(entry_params.merge(user_id: current_user.id))
    if @entry.save
      redirect_to @entry, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /entries/1
  def update
    @entry = Entry.find(params[:id])
    head :unauthorized and return unless @entry.user == current_user
    if @entry.update(entry_params)
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /entries/1
  def destroy
    @entry = Entry.find(params[:id])
    head :unauthorized and return unless @entry.user == current_user
    @entry.destroy
    redirect_to entries_path, notice: 'Entry was successfully destroyed.'
  end

  private

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.fetch(:entry, {}).permit(:title, :description, :notes, :content, :tag_list)
    end
end
