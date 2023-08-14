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

user_names = ["Yumi", "Mai", "Kei", "Kaoru", "Shoma"]
user_names.each do |name|
  user = User.create(
    email: "#{name.downcase}@example.com",
    password: "password",
  )
  
  UserProfile.create(
    name: name,
    user_id: user.id
  )
end

song_titles = ["マリーゴールド", "うっせぇわ", "プロローグ", "カブトムシ", "怪獣の花唄"]

artist_names = ["あいみょん", "Ado", "Uru", "aiko", "Vaundy"]
artist_lyrics = {} 

artist_names.each_with_index do |name, index|
  user = User.all.sample

  artist_lyric = Lyric.create(
    phrase: "Lyric phrase for #{name}",
    detail: "Lyric detail for #{name}",
    user: user
  )
  artist_lyrics[name] = artist_lyric

  artist = Artist.create(name: name, lyric: artist_lyric)

  song_lyric = Lyric.create(
    phrase: "Song lyric for #{song_titles[index]}",
    detail: "Song lyric detail for #{song_titles[index]}",
    user: user,
    feelings: [Feeling.all.sample]
  )
  Song.create(title: song_titles[index], lyric: song_lyric)
end

comment_contents = ["めっちゃいい歌詞！", "この歌詞好きです。", "何度も聞くと意味がわかってきた！", "私もこれ好き！", "やばい！"]
Lyric.all.each do |lyric|
  user = User.all.sample
  
  comment = Comment.new(content: comment_contents.sample, user: user)
  comment.lyric = lyric
  comment.save

  favorite = Favorite.new(user: user, lyric: lyric)
  favorite.save
end