require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションのテスト' do
    context '内容が空の場合' do
      it 'バリデーションに失敗すること' do
        comment = Comment.new(lyric_id: 1, content: '')
        expect(comment).not_to be_valid
      end
    end
  end
end