class ProjectsController < ApplicationController

  def index
    @projects = Project.where(owner_id: current_user.id)
  end

  def show
    @project = Project.find(params[:id])
    head :unauthorized and return unless @project.owner == current_user
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
    head :unauthorized and return unless @project.owner == current_user
  end

  def create
    head :unauthorized and return unless current_user
    @project = Project.new(project_params.merge(user_id: current_user.id))
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end
  
  def update
    @project = Project.find(params[:id])
    head :unauthorized and return unless @project.user == current_user
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    head :unauthorized and return unless @project.user == current_user
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end
  
  private

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.fetch(:project, {}).permit(:title, :description)
    end

end
