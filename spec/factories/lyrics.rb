FactoryBot.define do
  factory :lyric do
    detail { 'test_detail' }
    phrase { 'test_phrase' }

    trait :with_feeling do
      after(:build) do |lyric|
        feelings = [
          Feeling.first || create(:feeling),
          Feeling.second || create(:feeling, :feeling2),
          Feeling.third || create(:feeling, :feeling3)
        ]
        lyric.lyrics_feelings << build(:lyrics_feeling, lyric: lyric, feeling: feelings[0])
      end
    end
    trait :with_feeling2 do
      after(:build) do |lyric|
        feelings = [
          Feeling.first || create(:feeling),
          Feeling.second || create(:feeling, :feeling2),
          Feeling.third || create(:feeling, :feeling3)
        ]
        lyric.lyrics_feelings << build(:lyrics_feeling, lyric: lyric, feeling: feelings[1])
      end
    end
    trait :with_feeling3 do
      after(:build) do |lyric|
        feelings = [
          Feeling.first || create(:feeling),
          Feeling.second || create(:feeling, :feeling2),
          Feeling.third || create(:feeling, :feeling3)
        ]
        lyric.lyrics_feelings << build(:lyrics_feeling, lyric: lyric, feeling: feelings[2])
      end
    end
  end
end