class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index search]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = Comment.new
  end

  def index
    @posts = Post.page(params[:page]).per(10).order(created_at: 'desc')
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @categorys = Post.pluck(:category)
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to root_path if @post.user != current_user
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @posts = if params[:name].present?
               Post.where('name LIKE ?', "%#{params[:name]}%").page(params[:page]).per(10)
             elsif params[:category].present?
               Post.where(category: params[:category]).page(params[:page]).per(10)
             else
               Post.none
             end
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :name, :category, :size, :shop_url, :caption)
  end
end
