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

  private
  def post_params
   params.require(:post).permit(:post_image, :name, :category, :size, :shop_url, :caption)
  end
end

