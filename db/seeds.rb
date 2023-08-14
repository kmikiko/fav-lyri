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

song_titles = ["マリーゴールド", "HERO", "GIFT", "仲間", "怪獣の花唄"]
artist_names = ["あいみょん", "安室奈美恵", "Mr.Children", "ケツメイシ", "Vaundy"]
phrases = 
  ["でんぐり返しの日々",
  "どこまでもすべて君のために走る",
  "白と黒のその間に無限の色が広がってる",
  "楽しい時だけが仲間じゃないだろ",
  "落ちてく過去は鮮明で"
  ]
details = 
  ["〈でんぐり返しの日々〉って、ずっところころ回っていく、同じ日々を繰り返してたりとか、そういう意味合い？",
  "歌詞がほんとに素敵。 どんなに落ち込んでいてもこれを聞けば 勇気を貰えるし、逆に誰かを勇気づけたりする時にも 使えるしほんとにいい曲だから",
  "Mr.Childrenさんの世界観たっぷりで 歌詞のひとつひとつが心に響いてきて 聞き終わると心がほっこりできる曲です。 大切な人の事を思い出して 会いたくなる、本当に素敵な曲だと思います。",
  "辛い時にあきらめるなと背中をバシッと押してくれたり、俺がいると力強く言ってくれたり。 この曲を聴くと、そんな存在が周りにいることに気づかされ、励まされます。",
  "どれだけ明確な夢があっても過去ばかりを振り返っていてはつまらない人生になってしまいそうですよね。"
  ]
artist_lyrics = {}

artist_names.each_with_index do |name, index|
  user = User.all.sample

  lyric = Lyric.create(
    phrase: phrases[index],
    detail: details[index],
    user: user
  )

  artist = Artist.create(name: name, lyric_id: lyric.id)

  song_title = song_titles[index]
  song = Song.create(
    title: song_title,
    lyric_id: lyric.id,
  )
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