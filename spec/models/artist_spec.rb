require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'バリデーションのテスト' do
    context 'アーティスト名が空の場合' do
      it 'バリデーションに失敗すること' do
        artist = Artist.new(name: '', lyric_id: 1)
        expect(artist).not_to be_valid
      end
    end
  end
end