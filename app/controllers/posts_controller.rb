class PostsController < ApplicationController

  def new
    @post =Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = Comment.new
  end

  def index
    @posts = Post.all
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @categorys = Post.pluck(:category).uniq
  end


  def edit
    @post = Post.find(params[:id])
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
      @posts = Post.where('name LIKE ?', "%#{params[:name]}%")
    elsif
      @posts = Post.where(category: "バスルーム")
      @posts = Post.where(category: "クローゼット")
      @posts = Post.where(category: "リビング")
      @posts = Post.where(category: "キッチン")
      @posts = Post.where(category: "トイレ")
      # @posts = Post.none
    end
  end

  private
  def post_params
   params.require(:post).permit(:post_image, :name, :category, :size, :shop_url, :caption)
  end
end

