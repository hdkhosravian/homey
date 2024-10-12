FactoryBot.define do
  factory :status_change do
    status { "in_progress" }
    association :user
    association :project
  end
end
