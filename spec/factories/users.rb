FactoryBot.define do
  factory :user do
    username "test_user"
    sequence(:email) { |n| "test#{n}@example.com" }
    password "test123"
    description "description"
    birth_date "1979-10-15"
    sex "男性"
    website "https://test.com/"
  end
end
