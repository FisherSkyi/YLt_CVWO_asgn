class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # @post.user = current_user # Assuming you have authentication
    if @post.save
      redirect_to @post, notice: "Post created successfully."
    else
      render :new, alert: "Failed to create post."
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
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

  def post_params
    params.require(:post).permit(:title, :content)
  end
end