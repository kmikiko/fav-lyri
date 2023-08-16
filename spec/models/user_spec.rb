require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    context 'メールアドレスが空の場合' do
      it 'バリデーションに失敗すること' do
        user = FactoryBot.build(:user, email: nil)
        expect(user.valid?).to eq(false)
      end
    end
    context 'パスワードが空の場合' do
      it 'バリデーションに失敗すること' do
        user = FactoryBot.build(:user, password: nil)
        expect(user.valid?).to eq(false)
      end
    end
    context 'パスワードが6文字未満の場合' do
      it 'バリデーションに失敗すること' do
        user = FactoryBot.build(:user, password: '12345')
        expect(user.valid?).to eq(false)
      end
    end
  end

  describe 'follow! メソッド' do
    it '他のユーザーをフォローできること' do
      user = User.new(email: 'test@sample.com', password: 'password')
      other_user = User.new(email: 'test2@sample.com', password: '12345')
      user.follow!(other_user)
      expect(user.following?(other_user)).to be_truthy
    end
  end

  describe 'unfollow! メソッド' do
    it 'フォローしているユーザーをアンフォローできること' do
      user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:second_user)
      user.follow!(other_user)
      user.unfollow!(other_user)
      expect(user.following?(other_user)).to be_falsy
    end
  end

  describe 'create_notification_follow! メソッド' do
    it 'フォロー通知を作成できること' do
      user = FactoryBot.create(:user)
      current_user = FactoryBot.create(:second_user)
      user.create_notification_follow!(current_user)
      expect(user.passive_notifications.last.action).to eq('follow')
    end
  end

  describe 'self.guest メソッド' do
    it 'ゲストユーザーを作成できること' do
      guest_user = User.guest
      expect(guest_user.persisted?).to be_truthy
    end
  end

  describe 'self.guest_admin メソッド' do
    it 'ゲスト管理者ユーザーを作成できること' do
      guest_admin_user = User.guest_admin
      expect(guest_admin_user.persisted?).to be_truthy
      expect(guest_admin_user.admin).to be_truthy
    end
  end
end