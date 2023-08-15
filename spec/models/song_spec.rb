require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションに失敗すること' do
        song = Song.new(title: '', lyric_id: 1)
        expect(song).not_to be_valid
      end
    end
  end
end