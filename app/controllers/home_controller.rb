class HomeController < ApplicationController
  def top
    @posts = Post.page(params[:page]).per(5)
    @user = User.find_by(id: params[:id])
  end
end
