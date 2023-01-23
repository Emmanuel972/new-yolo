class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy]

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.post = Post.find(params[:post_id])
    if @review.save
      redirect_to @review
    else
      render :new
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
