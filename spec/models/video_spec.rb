RSpec.describe Video, type: :model do
  it "has a valid factory" do
    expect(build(:video)).to be_valid
  end

  it "is invalid without title" do
    video = build(:video, title: nil)
    video.valid?
    expect(video.errors[:title]).to include("を入力してください")
  end

  it "is invalid without url" do
    video = build(:video, url: nil)
    video.valid?
    expect(video.errors[:url]).to include("を入力してください")
  end

  it "is invalid without date" do
    video = build(:video, date: nil)
    video.valid?
    expect(video.errors[:date]).to include("を入力してください")
  end

  it "is invalid without thumbnail" do
    video = build(:video, thumbnail: nil)
    video.valid?
    expect(video.errors[:thumbnail]).to include("を入力してください")
  end

  it "is invalid with a duplicate title" do
    create(:video, title: "video_title")
    video = build(:video, title: "video_title")
    video.valid?
    expect(video.errors[:title]).to include("はすでに存在します")
  end

  it "is invalid with a duplicate url" do
    create(:video, url: "video_url")
    video = build(:video, url: "video_url")
    video.valid?
    expect(video.errors[:url]).to include("はすでに存在します")
  end

  it "is invalid with a duplicate thumbnail" do
    create(:video, thumbnail: "video_thumbnail")
    video = build(:video, thumbnail: "video_thumbnail")
    video.valid?
    expect(video.errors[:thumbnail]).to include("はすでに存在します")
  end

  it "can have many reviews" do
    video = create(:video, :with_reviews)
    expect(video.reviews.length).to eq 3
  end
end
