FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
    admin { false }
  end

  factory :second_user, class: User do
    sequence(:email) { |n| "#{n}2@example.com" }
    password { 'password' }
    admin { false }
  end

end

