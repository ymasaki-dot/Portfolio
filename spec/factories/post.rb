FactoryBot.define do
  factory :post do
    name { Faker::Lorem.characters(number:30) }
    category { Faker::Lorem.characters(number:6) }
    caption { Faker::Lorem.characters(number:500) }
  end
end