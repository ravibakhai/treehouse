class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.property
  end

  def destroy
    @review = Review.find(params[:id])
    property = @review.property
    @review.destroy

    redirect_to property
  end

  private
    def review_params
      params.require(:review).permit(:comment, :star, :property_id)
    end
end
