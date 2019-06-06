class Review < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }
  belongs_to :user
  belongs_to :video

  scope :recent, -> { order(created_at: :desc) }
end
