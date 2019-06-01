class Video < ApplicationRecord
  has_many :reviews, dependent: :destroy
  ratyrate_rateable "評価"
  validates :title, uniqueness: true, presence: true
  validates :url, uniqueness: true, presence: true
  validates :date, presence: true
  validates :thumbnail, uniqueness: true, presence: true
  scope :recent, -> { order(date: :desc) }

  def self.download_videos
    first_flg = true

    next_page_token = ''

    a = []

    loop do
      if first_flg

        res = Video.search_videos(next_page_token)['items']

        res.each do |elem|
          a.unshift(elem)
        end

        next_page_token = Video.search_videos(next_page_token)['nextPageToken']

        first_flg = false

      else

        res = Video.search_videos(next_page_token)['items']

        res.each do |elem|
          a.unshift(elem)
        end

        next_page_token = Video.search_videos(next_page_token)['nextPageToken']

        break if next_page_token.nil?

      end
    end

    a.save_videos
  end

  def self.search_videos(next_page_token)
    params = URI.encode_www_form({
      part:  "snippet",
      key: 'AIzaSyDqFHLZvpC9NQ5JvCmck6KXu_fda-i62nM',
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
      key: 'AIzaSyDqFHLZvpC9NQ5JvCmck6KXu_fda-i62nM',
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
end
