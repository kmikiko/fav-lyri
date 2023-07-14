# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
feelings = ['悲しい時', '嬉しい時', '恋しい時', '楽しみたい時', '悔しい時', '疲れている時', 'イライラしている時', '切ない時']
feelings.each do |feeling_type|
  Feeling.create!(type: feeling_type)
end