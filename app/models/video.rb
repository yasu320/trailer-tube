class Video < ApplicationRecord
  has_many :reviews
  ratyrate_rateable "評価"
  validates :title, uniqueness: true, presence: true
  validates :url, uniqueness: true, presence: true
  validates :date, presence: true
  validates :thumbnail, uniqueness: true, presence: true
  scope :recent, -> { order(created_at: :desc) }

  def self.download_videos
    first_flg = true

    next_page_token = ''

    box = []

    loop do
      if first_flg

        res = Video.search_videos(next_page_token)['items']

        res.reverse_videos(box)

        next_page_token = Video.search_videos(next_page_token)['nextPageToken']

        first_flg = false

      else

        res = Video.search_videos(next_page_token)['items']

        res.reverse_videos(box)

        next_page_token = Video.search_videos(next_page_token)['nextPageToken']

        break if next_page_token.nil?

      end
    end

    box.save_videos
  end

  def self.search_videos(next_page_token)
    params = URI.encode_www_form({
      part:  "snippet",
      key: Rails.application.credentials.youtube[:youtube_api_key],
      maxResults:  "50",
      q: '映画　予告　公式',
      type:  'video',
      order: "date",
      pageToken: next_page_token,
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

class Array
  def save_videos
    self.each do |item|
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
    end
  end

  def reverse_videos(box)
    self.each do |r|
      box.unshift(r)
    end
  end
end
