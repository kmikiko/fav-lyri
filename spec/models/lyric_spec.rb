require 'rails_helper'

RSpec.describe Lyric, type: :model do
  describe 'バリデーションのテスト' do
    context 'フレーズが空の場合' do
      it 'バリデーションに失敗すること' do
        lyric = Lyric.new(phrase: '', detail: 'テスト詳細', user_id: 1)
        expect(lyric).not_to be_valid
      end
    end
  end
end