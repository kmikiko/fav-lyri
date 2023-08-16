FactoryBot.define do
  factory :lyric do
    detail { 'test_detail' }
    phrase { 'test_phrase' }
    user_id { 1 }
    association :artist
    association :song
    association :user
  end

  factory :artist do
    name { 'test_name' }
  end

  factory :song do
    title { 'test_title' }
  end


end