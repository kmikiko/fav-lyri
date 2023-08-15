FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}@example.com" }
    password { 'password' }
    admin { false }
    association :user_profile, factory: :user_profile
  end

  factory :second_user, class: User do
    sequence(:email) { |n| "#{n}2@example.com" }
    password { 'password' }
    admin { false }
    association :user_profile, factory: :user_profile
  end

  factory :user_profile do
    sequence(:name) { |n| "test_user#{n}" }
    introduction { Faker::Lorem.sentence }
  end
end

