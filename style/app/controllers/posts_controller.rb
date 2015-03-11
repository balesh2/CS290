class PostsController < ApplicationController
  before_filter :find_post, :only => [:edit, :update, :destroy]
  respond_to :html, :json

  def index
    @posts = Post.where(:users_id => current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    flash[:success] = "Successfully created post!" if @post.save
    respond_with @post, :location => posts_path
  end

  def edit
  end
  
  def update
    @post.update_attributes(post_params)
    respond_with @post, :location => posts_path
  end

  def destroy
    if @post.destroy
      flash[:success] = "Successfully deleted"
    else
      flash[:error] = "Error in deleting post"
    end
    respond_with @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :photo, :created_at, :updated_at, :users_id, :coords)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
