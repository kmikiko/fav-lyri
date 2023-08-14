# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# feelings = ['悲しい時', '嬉しい時', '恋しい時', '楽しみたい時', '悔しい時', '疲れている時', 'イライラしている時', '切ない時']
# feelings.each do |feeling_type|
#   Feeling.create!(sort: feeling_type)
# end

user_names = ["John", "Jane", "Michael", "Emily", "David"]
user_names.each do |name|
  user = User.create(
    email: Faker::Internet.unique.email,
    password: "password",
    confirmed_at: Time.now
  )
  
  UserProfile.create(
    name: name,
    user: user
  )
end

artist_names = ["あいみょん", "Ado", "Uru", "aiko", "Vaundy"]
artist_names.each do |name|
  artist = Artist.create(name: name, lyric: Lyric.create(phrase: "Lyric phrase for #{name}", detail: "Lyric detail for #{name}", user: User.all.sample))
end

comment_contents = ["めっちゃいい歌詞！", "この歌詞好きです。", "何度も聞くと意味がわかってきた！", "私もこれ好き！", "やばい！"]
Lyric.all.each do |lyric|
  user = User.all.sample
  
  Comment.create(content: comment_contents.sample, lyric: lyric, user: user)
  Favorite.create(user: user, lyric: lyric)
end

lyric_phrases = ["歌詞1", "歌詞2", "歌詞3", "歌詞4", "歌詞5"]
Lyric.all.each do |lyric|
  lyric.update(feelings: [Feeling.all.sample])
end
lyric_phrases.each do |phrase|
  Lyric.create(phrase: phrase, detail: "Lyric detail for #{phrase}", user: User.all.sample, feelings: [Feeling.all.sample])
end