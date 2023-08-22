require 'rails_helper'

RSpec.describe Artist, type: :model do
  let!(:user){FactoryBot.create(:user)}
  let!(:lyric){FactoryBot.create(:lyric, user_id:user.id)}
  describe 'バリデーションのテスト' do
    context 'アーティスト名が空の場合' do
      it 'バリデーションに失敗すること' do
        artist = Artist.new(name: '', lyric_id: lyric.id)
        expect(artist).not_to be_valid
      end
    end
    context '1文字以上のアーティスト名が登録された場合' do
      it 'バリデーションに成功すること' do
        artist = Artist.new(name: 'a', lyric_id: lyric.id)
        expect(artist).to be_valid
      end
    end
  end
end