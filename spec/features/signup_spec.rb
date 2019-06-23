RSpec.feature "Signup", type: :feature do
  feature "with invalid information" do
    background do
      visit new_user_registration_path
    end

    scenario "user cannot signup without information" do
      expect { click_on "登録する" }.not_to change(User, :count)
    end
  end

  feature "with valid information" do
    background do
      visit new_user_registration_path
    end

    scenario "user can create account" do
      expect {
        fill_in "ユーザーネーム",         with: "Example User"
        fill_in "メールアドレス",        with: "user@example.com"
        fill_in "パスワード",     with: "foobar"
        fill_in "パスワードの確認", with: "foobar"
        click_on "登録する"
      }.to change(User, :count).by(1)
    end
  end
end
