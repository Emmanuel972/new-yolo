class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_reviews, only: [:show]

  def index
    @posts = Post.all
  end

  def show
    @review = Review.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_reviews
    @reviews = Review.where(post: @post)
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
