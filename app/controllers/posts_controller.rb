class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
       redirect_to post_path(@post)
    else
      render:new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = Comment.new
  end

  def index
    @posts = Post.page(params[:page]).per(5)
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @categorys = Post.pluck(:category).uniq
  end


  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    if params[:name].present?
      @posts = Post.where('name LIKE ?', "%#{params[:name]}%").page(params[:page]).per(10)
    elsif params[:category].present?
      @posts = Post.where(category: params[:category]).page(params[:page]).per(10)
    else
      @posts = Post.none
      flash[:notice] = "検索したい商品名を入力してください"
    end
  end

  private
  def post_params
   params.require(:post).permit(:post_image, :name, :category, :size, :shop_url, :caption)
  end
end

