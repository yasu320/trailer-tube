User.create!(username:  "ゲスト",
             email: "guest@guest.com",
             password:              "guest123",
             password_confirmation: "guest123")

99.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(username:  username,
               email: email,
               password:              password,
               password_confirmation: password)
end