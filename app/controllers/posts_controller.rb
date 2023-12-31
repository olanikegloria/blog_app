class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @posts = Post.includes(:author)
      .includes(:comments)
      .where(author: params[:user_id])
      .order(created_at: :asc)
    @author = @posts.first.author unless @posts.first.nil?
    @user = User.find(params[:user_id])
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
    @post.likes.destroy_all
    @post.comments.destroy_all
    @post.destroy

    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
