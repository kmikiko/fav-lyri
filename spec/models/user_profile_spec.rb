require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションに失敗すること' do
        user_profile = UserProfile.new(name: '', user_id: 1)
        expect(user_profile).not_to be_valid
      end
    end
  end
end