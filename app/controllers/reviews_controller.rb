class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_video, only: [:index, :show, :new, :create]
  MAX_USER_REVIEWS = 10

  def index
    @reviews = @video.reviews.includes(:user).page(params[:page]).recent
  end

  def show
    @review = @video.reviews.find(params[:id])
  end

  def new
    @review = @video.reviews.new
  end

  def create
    @review = @video.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to video_path(@video)
    else
      render 'new'
    end
  end

  def user_reviews
    @user = User.find(params[:user_id])
    @videos = Video.includes(:reviews).where(reviews: { user_id: @user }).page(params[:page]).per(MAX_USER_REVIEWS)
  end

  private

  def review_params
    params.require(:review).permit(:title, :content)
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end
