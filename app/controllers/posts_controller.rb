class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author)
      .includes(:comments)
      .where(author: params[:user_id])
      .order(created_at: :asc)
    @author = @posts.first.author
  end

  def show
    @post = Post.includes(:author, comments: :user).find(params[:id])
    @current_user = User.first
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post created successfully!'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post

    if @post.destroy
      flash[:success] = 'Post was successfully deleted.'
    else
      flash[:error] = 'Error deleting the post.'
    end

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
