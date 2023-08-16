require 'rails_helper'

RSpec.describe Song, type: :model do
  let!(:user){FactoryBot.create(:user)}
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションに失敗すること' do
        user_profile = UserProfile.new(name: '', created_at: Time.now, user_id: user.id)
        expect(user_profile).not_to be_valid
      end
    end
    context '1文字以上の名前が登録された場合' do
      it 'バリデーションに成功すること' do
        user_profile = UserProfile.new(name: 'a', created_at: Time.now, user_id: user.id)
        expect(user_profile).to be_valid
      end
    end
  end
end