class IdeasController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      flash[:notice] = "Idea created successfully"
      redirect_to idea_path(@idea)
    else
      # render views/ideas/new.html.erb
      render :new
    end
  end

  def show
    @review = Review.new
    @reviews = @idea.reviews.order(created_at: :desc)
    # @like = @idea.likes.find_by(user: current_user)
  end

  def index
    # @ideas = Idea.all

    @ideas = Idea.order(created_at: :desc)
    # @like = @idea.likes.find_by(user: current_user)

  end

  def edit
    unless can?(:crud, @idea)
      redirect_to root_path, alert: 'Not Authorized'
    end
  end

  def update
    # attempt to edit the existing question with new values
    if @idea.update idea_params
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Idea Deleted!"
    @idea.destroy
    redirect_to ideas_path
  end

  def liked
    @ideas = current_user.liked_ideas.order('likes.created_at DESC')
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def find_idea
    # get the current value inside of the db
    @idea = Idea.find params[:id]
  end

  def authorize!
    redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @idea)
  end
end