FactoryBot.define do
  factory :feeling do
    sort  { '悲しい' }

    trait :feeling2 do
      sort  { '嬉しい' }
    end
    trait :feeling3 do
      sort  { '疲れた' }
    end
  end
end