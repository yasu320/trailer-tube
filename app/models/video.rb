class Video < ApplicationRecord
  has_many :reviews
  ratyrate_rateable "評価"

  def self.save_videos
    Video.search_videos['items'].each do |item|
      title = item['snippet']['title']
      url = item['id']['videoId']
      date = item['snippet']['publishedAt']
      thumbnail = item['snippet']['thumbnails']['high']['url']

      video ||= Video.create(
        title:      title,
        url:        url,
        date:       date,
        thumbnail: thumbnail
      )

      description = video.search_by(video.url)['items'][0]["snippet"]['description']

      video.attributes = { description: description }

      video.save

      video
    end
  end

  def self.search_videos
    params = URI.encode_www_form({
      part:  "snippet",
      key: Rails.application.credentials.youtube[:youtube_api_key],
      maxResults:  "50",
      q: '映画　予告　公式',
      type:  'video',
      order: "date",
      videoCategoryId: '1',
    })

    uri = URI.parse("https://www.googleapis.com/youtube/v3/search?#{params}")

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.get(uri.request_uri)
    end

    @result = JSON.parse(response.body)
  end

  def search_by(video_id)
    params = URI.encode_www_form({
      part:  "snippet",
      key: Rails.application.credentials.youtube[:youtube_api_key2],
      id: video_id,
    })

    uri = URI.parse("https://www.googleapis.com/youtube/v3/videos?#{params}")

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.get(uri.request_uri)
    end

    @video = JSON.parse(response.body)
  end
end
