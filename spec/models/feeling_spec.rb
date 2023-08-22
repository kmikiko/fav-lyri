require 'rails_helper'

RSpec.describe Feeling, type: :model do
  describe 'バリデーションのテスト' do
    context 'アーティスト名が空の場合' do
      it 'バリデーションに失敗すること' do
        feeling = Feeling.new(sort: '')
        expect(feeling).not_to be_valid
      end
    end
    context '1文字以上のアーティスト名が登録された場合' do
      it 'バリデーションに成功すること' do
        feeling = Feeling.new(sort: 'a')
        expect(feeling).to be_valid
      end
    end
  end
end