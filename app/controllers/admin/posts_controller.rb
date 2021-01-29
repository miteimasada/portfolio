class Admin::PostsController < ApplicationController
  before_action :admin_user

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
  end

  def popular
    @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count

    @comments = @post.comments
    @comment = @post.comments.build
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to '/', notice: '新しい記事を投稿しました' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '投稿を編集しました' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to 'admin/posts', notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  def search
    @posts = Post.search(params[:search])
  end

  private

    def admin_user
      redirect_to(root_url) unless @current_user.admin?
    end

end
