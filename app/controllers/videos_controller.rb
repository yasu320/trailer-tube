class VideosController < ApplicationController
  MAX_RESULTS = 3
  def index
    @videos = Video.page(params[:page]).per(18).recent
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews.includes(user: { image_attachment: :blob }).limit(MAX_RESULTS).recent
  end
end
