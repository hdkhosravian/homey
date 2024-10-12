FactoryBot.define do
  factory :project do
    title { Faker::App.name }
    description { Faker::Lorem.paragraph }
    association :user
  end
end
