FactoryBot.define do
  factory :notification do
    message { Faker::Lorem.sentence }
    association :trackable, factory: :project  # Change to track different models like `status_change`
    association :user
    association :project
  end
end
