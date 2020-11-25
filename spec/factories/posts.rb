FactoryBot.define do
  factory :post do
    user_id {"1"}
    title { "test" }
    content { "tester" }
    association :user
  end
end
