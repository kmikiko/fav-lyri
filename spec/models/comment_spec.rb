require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user){FactoryBot.create(:user)}
  let!(:second_user){FactoryBot.create(:second_user)}
  let!(:lyric){FactoryBot.create(:lyric, user_id:user.id)}
  describe 'バリデーションのテスト' do
    context '内容が空の場合' do
      it 'バリデーションに失敗すること' do
        comment = Comment.new(lyric_id: lyric.id, user_id: second_user.id, content: '')
        expect(comment).not_to be_valid
      end
    end
    context '内容が1文字以上登録された場合' do
      it 'バリデーションに成功すること' do
        comment = Comment.new(lyric_id: lyric.id, user_id: second_user.id, content: 'a')
        expect(comment).to be_valid
      end
    end
  end
end