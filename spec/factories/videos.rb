FactoryBot.define do
  factory :video do
    title "test_video"
    url "test_url"
    date "2005-02-14"
    description "test-test-test"
    thumbnail "test_thumbnail"

    trait :with_reviews do
      after(:create) { |video| create_list(:review, 3, video: video) }
    end
  end
end
