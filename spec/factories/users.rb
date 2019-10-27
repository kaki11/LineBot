FactoryBot.define do
  factory :user do
    name { "testuter" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "Pasword0000" }
    password_confirmation { "Pasword0000" }
  end
end
