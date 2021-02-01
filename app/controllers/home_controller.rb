class HomeController < ApplicationController

  def top
    @posts = Post.all.page(params[:page]).order(created_at: :desc).per(10)
    @popular = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end

  def index
    @user = User.find_by(id: params[:id])
    @posts = Post.all.page(params[:page]).order(created_at: :desc).per(10)
    @popular = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end

  def timeline
    @timeline = Post.where(user_id: [@current_user.following]).order(created_at: :desc)
  end

  def likes
    @likes = Like.where(user_id: @current_user.id)
  end

end
