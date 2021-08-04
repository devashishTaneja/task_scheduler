FactoryBot.define do
  factory :task do
    title { "Task Title" }
    body { "Task Content" }
    expires_on {Time.now+1000}
    association :user
  end
end