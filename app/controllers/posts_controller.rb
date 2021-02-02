class PostsController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update, :destroy, :new]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, {only: [:edit,:update,:destroy]}

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.page(params[:page]).search(params[:search]).order(created_at: :desc)
  end

  def popular
    @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts = Post.all
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count

    @comments = @post.comments
    @comment = @post.comments.build
  end

  # GET /posts/new
  def new
    @post = Post.new
    @user = User.find_by(id: params[:id])
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
        format.html { redirect_to "/index/#{@current_user.id}", notice: '新しい記事を投稿しました' }
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
    @post.destroy
    respond_to do |format|
      format.html { redirect_to "/users/#{@current_user.id}", notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts")
    end
  end

  def search
    @posts = Post.search(params[:search])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :step1, :step2, :step3, :user_id)
    end

end
