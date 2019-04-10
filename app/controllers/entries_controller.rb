class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  def index
    @entries = Entry.all
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
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
    render status: :unauthorized and return unless @entry.user == current_user
  end

  # POST /entries
  def create
    render status: :unauthorized and return unless current_user
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
    render status: :unauthorized and return unless @entry.user == current_user
    if @entry.update(entry_params)
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /entries/1
  def destroy
    @entry = Entry.find(params[:id])
    redirect_to entries_url, notice: 'Cannot destroy unowned resource.' and return unless @entry.user == current_user
    @entry.destroy
    redirect_to entries_url, notice: 'Entry was successfully destroyed.'
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.fetch(:entry, {}).permit(:title, :description, :notes, :content, :tag_list)
    end
end
