class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.profile = params[:profile]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  private
    def admin_user
      redirect_to(root_url) unless @current_user.admin?
    end
end
