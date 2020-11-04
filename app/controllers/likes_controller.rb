class LikesController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: [:create, :destroy]

  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id,post_id: params[:post_id])
    @like.destroy
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
