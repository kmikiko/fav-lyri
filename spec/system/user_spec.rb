require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user, name:'カツオ' ,email:'katsuo@example.com') }
  let!(:second_user) {FactoryBot.create(:second_user)}
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  describe '新規ユーザー作成機能' do
    context 'ユーザーを新規作成した場合' do
      it '投稿一覧ページ（検索欄含む）が表示される' do
        visit new_user_path
        fill_in 'user[email]', with: 'sazae@example.com'
        fill_in 'user[password]', with: '111111'
        fill_in, 'user[password_confirmation]', with: '111111'
        fill_in, 'user[user_profile_attributes][name]', with: 'サザエ'
        fill_in, 'user[user_profile_attributes][introduction]', with: 'サザエ'
        click_on "アカウント登録"
        expect(page).to have_content 'a'
      end
    end
  
    context 'ユーザーログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).to_not have_content 'タスク管理'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      visit new_session_path
      fill_in "session[email]",with: user.email
      fill_in "session[password]",with: user.password
      click_on "ログイン"
    end
    context '登録済みのユーザーがログインした場合' do
      it '作成したユーザーのマイページが表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content user.email
      end
    end
  
    context '一般ユーザーが他のユーザーの詳細画面にアクセスしようとした場合' do
      it 'タスク一覧画面に遷移する' do
        visit user_path(user2.id)
        expect(page).to have_content 'タスク管理'
        expect(page).to_not have_content user2.name
      end
    end

    context 'ログアウトした場合' do
      it 'タスク一覧が表示できなくなる' do
        click_on 'Logout'
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).to_not have_content 'タスク管理'
      end
    end
  end

  describe '管理画面の機能' do
    before do
      visit new_session_path
      fill_in "session[email]",with: admin_user.email
      fill_in "session[password]",with: admin_user.password
      click_on "ログイン"
    end
    context '管理者として登録されている場合' do
      it '管理画面が表示される' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー管理'
      end
    end
  
    context '一般ユーザーとして登録されている場合' do
      it '管理画面が表示されない' do
        click_on 'Logout'
        visit new_session_path
        fill_in "session[email]",with: user.email
        fill_in "session[password]",with: user.password
        click_on "ログイン"
        visit admin_users_path
        expect(page).to_not have_content 'ユーザー管理'
      end
    end

    context '管理ユーザーがユーザー作成した場合' do
      it '作成したユーザーが管理画面に追加される' do
        visit admin_users_path
        click_on 'ユーザー作成'
        fill_in 'user[name]', with: 'ワカメ'
        fill_in 'user[email]', with: 'wakame@example.com'
        fill_in 'user[password]', with: '111111'
        fill_in 'user[password_confirmation]', with: '111111'
        click_on "登録"
        expect(page).to have_content 'ワカメ' 
        expect(page).to have_content 'wakame@example.com'
      end
    end

    context '管理ユーザーが他のユーザーの詳細画面にアクセスした場合' do
      it '詳細画面の表示ができる' do
        visit user_path(user.id)
        expect(page).to have_content user.name
        expect(page).to have_content user.email
      end
    end

    context '管理ユーザーが他のユーザーの編集画面にアクセスした場合' do
      it 'ユーザー情報の編集ができる' do
        visit edit_admin_user_path(user.id)
        fill_in 'user[name]', with: 'マスオ'
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password_confirmation
        click_on "登録"
        expect(page).to have_content 'マスオ'
      end
    end
    before do
      FactoryBot.create(:user2, name: 'name10', id: 10)
      FactoryBot.create(:user2, name: 'name20', id: 20)
      FactoryBot.create(:user2, name: 'name30', id: 30)
    end
    context '管理ユーザーが他のユーザーを削除した場合'  do
      it '削除されたユーザーはログインができなくなる' do
        visit admin_users_path
        # find('#delete_10').click
        page.accept_confirm do
          click_link('delete_10')
        end
        # page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'name20'
        expect(page).not_to have_content 'name10'
      end
    end
  end
end
