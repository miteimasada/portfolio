class HomeController < ApplicationController
  def top
    @posts = Post.page(params[:page]).order(created_at: :desc).per(10)
    @user = User.find_by(id: params[:id])
    @popular = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
  end
end
