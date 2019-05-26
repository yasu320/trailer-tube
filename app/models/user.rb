class User < ApplicationRecord
  require 'open-uri'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:twitter, :facebook],
         :authentication_keys => [:username]
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  ratyrate_rater

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user ||= User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        profile_image_url: auth.info.image,
        username: auth.info.name
      )
    end

    user
  end

  def download_and_attach_image
    file = open(image_url)
    image.attach(io: file,
                 filename: "profile_image.#{file.content_type_parse.first.split("/").last}",
                 content_type: file.content_type_parse.first)
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def image_url
    if provider == 'twitter'
      profile_image_url&.gsub!("_normal", "")

    elsif provider == 'facebook'
      profile_image_url + "?type=large"
    end
  end
end
