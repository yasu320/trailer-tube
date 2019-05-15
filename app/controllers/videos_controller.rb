class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find_by(url: params[:id])
  end
end
