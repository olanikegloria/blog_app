class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(user_id: @post.author.id, id: @post.id), notice: 'Comment added successfully'
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    if @comment.destroy
      flash[:success] = 'Comment was successfully deleted.'
    else
      flash[:error] = 'Error deleting the comment.'
    end

    redirect_to post_path(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
