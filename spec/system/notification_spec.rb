require 'rails_helper'
RSpec.describe '通知機能', type: :system do
  let!(:user) { FactoryBot.create(:user,email:'katsuo@example.com')}
  let!(:user_profile) {FactoryBot.create(:user_profile, user_id:user.id)}
  let!(:second_user) {FactoryBot.create(:second_user)}
  let!(:user_profile2) {FactoryBot.create(:user_profile, user_id:second_user.id)}
  let!(:admin_user) {FactoryBot.create(:admin_user)}
  let!(:user_profile3) {FactoryBot.create(:user_profile, user_id:admin_user.id)}
  let!(:lyric) {FactoryBot.create(:lyric, phrase:'test1', user_id:user.id)}
  let!(:song){FactoryBot.create(:song, lyric_id: lyric.id)}
  let!(:artist){FactoryBot.create(:artist, lyric_id: lyric.id)}
  describe '通知作成のテスト' do
    before do
      visit new_user_session_path
      fill_in "user[email]",with: second_user.email
      fill_in "user[password]",with: second_user.password
      click_button "ログイン"
      sleep(3)
    end
    context '他のユーザーにフォローされた場合' do
      it '通知が作成される' do
        visit user_path(user.id)
        sleep(1)
        click_button 'follow'
        click_on 'ログアウト'
        visit new_user_session_path
        fill_in "user[email]",with: user.email
        fill_in "user[password]",with: user.password
        click_button "ログイン"
        visit notifications_path
        follow_test_element = find('#follow_test')
        name_test_element = find('#test_name')
        expect(follow_test_element).to have_content "あなたをフォローしました"
        expect(name_test_element).to have_content user_profile2.name
      end
    end
    context '他のユーザーにコメントされた場合' do
      it '通知が作成される' do
        visit lyric_path(lyric.id)
        fill_in 'comment[content]',with: '春夏秋冬'
        click_button 'Comment'
        click_on 'ログアウト'
        visit new_user_session_path
        fill_in "user[email]",with: user.email
        fill_in "user[password]",with: user.password
        click_button "ログイン"
        visit notifications_path
        comment_test_element = find('#comment_test')
        name_test_element = find('#test_name')
        expect(comment_test_element).to have_content "コメントしました"
        expect(name_test_element).to have_content user_profile2.name
      end
    end
    context '他のユーザーにお気に入りされた場合' do
      it '通知が作成される' do
        visit lyric_path(lyric.id)
        click_on 'お気に入り'
        click_on 'ログアウト'
        visit new_user_session_path
        fill_in "user[email]",with: user.email
        fill_in "user[password]",with: user.password
        click_button "ログイン"
        visit notifications_path
        favorite_test_element = find('#favorite_test')
        name_test_element = find('#test_name')
        expect(favorite_test_element).to have_content "お気に入りしました"
        expect(name_test_element).to have_content user_profile2.name
      end
    end
  end

end