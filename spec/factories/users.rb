FactoryBot.define do
  factory :user do
    name { "testuter" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password_digest { "password" }
  end
end
