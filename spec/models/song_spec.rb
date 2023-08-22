require 'rails_helper'

RSpec.describe Song, type: :model do
  let!(:user){FactoryBot.create(:user)}
  let!(:lyric){FactoryBot.create(:lyric, user_id:user.id)}
  describe 'バリデーションのテスト' do
    context 'タイトルが空の場合' do
      it 'バリデーションに失敗すること' do
        song = FactoryBot.build(:song, title: '', lyric_id: lyric.id)
        expect(song).not_to be_valid
      end
    end
    context '1文字以上のタイトルが登録された場合' do
      it 'バリデーションに成功すること' do
        song = Song.new(title: 'a', lyric_id: lyric.id)
        expect(song).to be_valid
      end
    end
  end
end