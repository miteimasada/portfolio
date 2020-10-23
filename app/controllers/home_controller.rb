class HomeController < ApplicationController
  def top
    @posts = Post.all.order(created_at: :desc)
    @user = User.find_by(id: params[:id])
  end
end
