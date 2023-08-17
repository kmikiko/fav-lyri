require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user,email:'katsuo@example.com') }
  let!(:user_profile) {FactoryBot.create(:user_profile, name: 'カツオ', user_id:user.id)}
  let!(:second_user) {FactoryBot.create(:second_user)}
  let!(:user_profile2) {FactoryBot.create(:user_profile, user_id:second_user.id)}
  let!(:admin_user) {FactoryBot.create(:admin_user)}
  let!(:user_profile3) {FactoryBot.create(:user_profile, user_id:admin_user.id)}
  let!(:lyric) {FactoryBot.create(:lyric, phrase:'test', user_id:user.id)}
  let!(:song){FactoryBot.create(:song, lyric_id: lyric.id)}
  let!(:artist){FactoryBot.create(:artist, lyric_id: lyric.id)}
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
        sleep(3)
        find("#detail_link").click
        sleep(6)
        expect(page).to have_link 'Play Full'
        expect(page).to have_content 'test'
      end
      it 'ランキングの閲覧ができる' do
        visit lyrics_path
        click_on "ranking"
        sleep(3)
        expect(page).to have_content '第1位'
        expect(page).to have_content 'test'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      visit new_user_session_path
      fill_in "user[email]",with: user.email
      fill_in "user[password]",with: user.password
      click_button "ログイン"
      sleep(3)
    end
    context '登録済みのユーザーがログインした場合' do
      it '投稿一覧ページ（検索欄含む）に遷移する' do
        expect(page).to have_button '検索'
        expect(page).to have_content 'ログインしました'
      end
    end
  
    context 'ユーザーが他のユーザーの詳細画面にアクセスした場合' do
      it '限られた情報のみが表示される' do
        visit user_path(second_user.id)
        sleep(1)
        expect(page).to have_button 'follow'
        expect(page).to_not have_content 'メールアドレス'
        expect(page).to_not have_button 'favorites'
        expect(page).to_not have_button 'follower'
        expect(page).to_not have_button 'followed'
      end
    end

    context 'ユーザーが自分の詳細画面にアクセスした場合' do
      it 'ユーザーに関する情報が表示される' do
        visit user_path(user.id)
        sleep(1)
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_button 'favorites'
        expect(page).to have_button 'follower'
        expect(page).to have_button 'followed'
      end
    end

    context 'ログアウトした場合' do
      it '限られた情報のみが表示される' do
        click_on 'ログアウト'
        visit user_path(second_user.id)
        sleep(1)
        expect(page).to_not have_content 'メールアドレス'
        expect(page).to_not have_button 'favorites'
        expect(page).to_not have_button  'follower'
        expect(page).to_not have_button  'followed'
      end
    end
  end

  describe '管理画面の機能' do
    before do
      visit new_user_session_path
      fill_in "user[email]",with: admin_user.email
      fill_in "user[password]",with: admin_user.password
      click_button "ログイン"
      sleep(2)
    end
    context '管理者として登録されている場合' do
      it '管理画面が表示される' do
        visit rails_admin_path
        expect(page).to have_content 'サイト管理'
      end
    end
  end
  describe 'フォロー機能' do
    before do
      visit new_user_session_path
      fill_in "user[email]",with: second_user.email
      fill_in "user[password]",with: second_user.password
      click_button "ログイン"
      sleep(2)
    end
    context '他のユーザーのユーザーページを訪れた場合' do
      it 'フォローボタンが表示される' do
        visit user_path(user.id)
        sleep(1)
        expect(page).to have_button 'follow'
      end
    end
    context '他のユーザーをフォローした場合' do
      it '自分のユーザーページを経由しフォローしたユーザーの一覧が確認できる' do
        visit user_path(user.id)
        sleep(1)
        click_button 'follow'
        visit user_path(second_user.id)
        sleep(1)
        click_button 'followed'
        expect(page).to have_content'カツオ'
      end
    end
    context 'フォローしたユーザーのユーザーページを訪れた場合' do
      it 'フォロー解除ボタンが表示される' do
        visit user_path(user.id)
        sleep(1)
        click_button 'follow'
        visit user_path(user.id)
        sleep(1)
        expect(page).to have_button 'follow解除'
      end
    end
    context '他のユーザーをフォロー解除した場合' do
      it 'フォロー一覧から消える' do
        visit user_path(user.id)
        sleep(1)
        click_button 'follow'
        visit user_path(user.id)
        sleep(1)
        click_button 'follow解除'
        visit user_path(second_user.id)
        click_button 'followed'
        expect(page).to_not have_content'カツオ'
      end
    end
  end
end
