class PostsController < ApplicationController

  before_action :require_login, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:user, :tags).all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user 
    if @post.save
      create_new_tags
      redirect_to @post, notice: "Post created successfully."
    else
      render :new, alert: "Failed to create post."
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      create_new_tags
      redirect_to @post, notice: "Post updated successfully."
    else
      render :edit, alert: "Failed to update post."
    end
  end

  def destroy
    @post = Post.find(params[:id])
    Rails.logger.info "Attempting to delete post: #{@post.inspect}"
    if @post.destroy
      Rails.logger.info "Post deleted successfully!"
      redirect_to posts_path, notice: "Post deleted successfully."
    else
      Rails.logger.error "Failed to delete post: #{@post.errors.full_messages}"
      redirect_to post_path(@post), alert: "Failed to delete the post."
    end
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def authorize_user
    unless @post.user == current_user
      redirect_to posts_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def create_new_tags
    return unless params[:post][:new_tags].present?

    new_tags = params[:post][:new_tags].split(',').map(&:strip).reject(&:blank?)
    new_tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @post.tags << tag unless @post.tags.include?(tag)
    end
  end
end