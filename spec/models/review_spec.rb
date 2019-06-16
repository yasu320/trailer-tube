RSpec.describe Review, type: :model do
  it "has a valid factory" do
    expect(build(:review)).to be_valid
  end

  it "is invalid without title" do
    review = build(:review, title: nil)
    review.valid?
    expect(review.errors[:title]).to include("を入力してください")
  end

  it "is invalid without content" do
    review = build(:review, content: nil)
    review.valid?
    expect(review.errors[:content]).to include("を入力してください")
  end

  it "when title is too long" do
    review = build(:review, title: 'a' * 31)
    review.valid?
    expect(review.errors[:title]).to include("は30文字以内で入力してください")
  end

  it "when content is too long" do
    review = build(:review, content: 'a' * 1001)
    review.valid?
    expect(review.errors[:content]).to include("は1000文字以内で入力してください")
  end
end
