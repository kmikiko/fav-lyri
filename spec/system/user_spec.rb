require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user,email:'katsuo@example.com') }
  let!(:user_profile) {FactoryBot.create(:user_profile, user_id:user.id)}
  let!(:second_user) {FactoryBot.create(:second_user)}
  let!(:admin_user) {FactoryBot.create(:admin_user)}
  let!(:lyric) {FactoryBot.create(:lyric, phrase:'test', user_id:user.id)}
  let!(:song){FactoryBot.create(:song, lyric_id: lyric.id)}
  let!(:artist){FactoryBot.create(:artist, lyric_id: lyric.id)}
  # let!(:impression){Impression.new(ip_address:111111, user_id: second_user.id)}
  describe '新規ユーザー作成機能' do
    context 'ユーザーを新規作成した場合' do
      it '投稿一覧ページ（検索欄含む）に遷移する' do
        visit new_user_registration_path
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: '111111'
        fill_in 'user[password_confirmation]', with: '111111'
        fill_in 'user[user_profile_attributes][name]', with: 'サザエ'
        fill_in 'user[user_profile_attributes][introduction]', with: 'サザエ'
        click_on "アカウント登録"
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end
    context 'ユーザーログインせず投稿一覧画面に飛んだ場合' do
      it '投稿一覧の閲覧ができる' do
        visit lyrics_path
        expect(page).to have_button '検索'
        expect(page).to have_link 'ログイン'
        expect(page).to_not have_link 'ログアウト'
      end
      it '投稿詳細の閲覧ができる' do
        visit lyrics_path
        click_on "詳細"
        sleep(3)
        expect(page).to have_content 'お気に入り'
        expect(page).to have_content 'test'
      end
      it 'ランキングの閲覧ができる' do
        visit lyrics_path
        click_on "ranking"
        sleep(6)
        expect(page).to have_content '第1位'
        expect(page).to_not have_content 'test'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      visit new_user_session_path
      fill_in "session[email]",with: user.email
      fill_in "session[password]",with: user.password
      click_on "ログイン"
    end
    context '登録済みのユーザーがログインした場合' do
      it '投稿一覧ページ（検索欄含む）に遷移する' do
        expect(page).to have_content '検索'
      end
    end
  
    context 'ユーザーが他のユーザーの詳細画面にアクセスした場合' do
      it '限られた情報のみが表示される' do
        visit user_path(second_user.id)
        expect(page).to have_content 'follow'
        expect(page).to have_content 'ワカメ'
        expect(page).to_not have_content 'メールアドレス'
        expect(page).to_not have_content 'favorites'
        expect(page).to_not have_content 'follower'
        expect(page).to_not have_content 'followed'
      end
    end

    context 'ユーザーが自分の詳細画面にアクセスした場合' do
      it 'ユーザーに関する情報が表示される' do
        visit user_path(user.id)
        expect(page).to_not have_content 'follow'
        expect(page).to have_content 'カツオ'
        expect(page).to_not have_content 'メールアドレス'
        expect(page).to_not have_content 'favorites'
        expect(page).to_not have_content 'follower'
        expect(page).to_not have_content 'followed'
      end
    end

    context 'ログアウトした場合' do
      it '限られた情報のみが表示される' do
        click_on 'ログアウト'
        visit user_path(second_user.id)
        expect(page).to have_content 'follow'
        expect(page).to have_content 'ワカメ'
        expect(page).to_not have_content 'メールアドレス'
        expect(page).to_not have_content 'favorites'
        expect(page).to_not have_content 'follower'
        expect(page).to_not have_content 'followed'
      end
    end
  end

  describe '管理画面の機能' do
    before do
      visit new_user_session_path
      fill_in "session[email]",with: admin_user.email
      fill_in "session[password]",with: admin_user.password
      click_on "ログイン"
    end
    context '管理者として登録されている場合' do
      it '管理画面が表示される' do
        visit rails_admin_path
        expect(page).to have_content 'サイト管理'
      end
    end
  
    context '一般ユーザーとして登録されている場合' do
      it '管理画面が表示されない' do
        click_on 'ログアウト'
        visit new_user_session_path
        fill_in "session[email]",with: user.email
        fill_in "session[password]",with: user.password
        click_on "ログイン"
        visit rails_admin_path
        expect(page).to_not have_content 'サイト管理'
      end
    end
  end
end
