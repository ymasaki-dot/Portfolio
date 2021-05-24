FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:20) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:50) }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
  end
end