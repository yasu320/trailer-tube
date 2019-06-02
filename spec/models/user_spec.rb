RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
  it "is invalid without username" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("を入力してください")
  end

  it "is invalid without an email address" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid with a duplicate email address" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
end
