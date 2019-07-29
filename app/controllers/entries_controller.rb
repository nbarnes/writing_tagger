class EntriesController < ApplicationController

  # GET /entries
  def index
    @entries = [] and return unless current_user
    @entries = current_user.accessible_entries
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
    authorize_entry(params[:id])
  end

  # GET /entries/new
  def new
    redirect_to entries_path, notice: 'You must be logged in to create an entry.' and return unless current_user
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    authorize_entry(params[:id])
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
    authorize_entry(params[:id])
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

  def authorize_entry(id)
    @entry = Entry.find(params[:id])
    head :unauthorized and return unless (@entry.user == current_user || current_user.member_entries.include?(@entry))
  end

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.fetch(:entry, {}).permit(:title, :description, :notes, :content, :tag_list)
    end
end
