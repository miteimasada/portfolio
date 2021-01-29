class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user_id = @current_user.id
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to("admin/posts/#{params[:post_id]}")
    else
      flash[:notice] = "コメントできませんでした"
      redirect_to("posts/#{params[:post_id]}")
    end
  end

  def destroy
    @comment=Comment.find(params[:id])
    @comment.destroy
    if @comment.destroy
      flash[:notice] = "コメントを削除しました"
      redirect_to("admin/posts/#{params[:post_id]}")
    else
      flash[:notice] = "コメントの削除に失敗しました"
      redirect_to("posts/#{params[:post_id]}")
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
