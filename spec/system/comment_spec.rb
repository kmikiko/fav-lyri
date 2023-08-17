require 'rails_helper'
RSpec.describe 'コメント機能', type: :system do
  let!(:user) { FactoryBot.create(:user,email:'katsuo@example.com')}
  let!(:user_profile) {FactoryBot.create(:user_profile, user_id:user.id)}
  let!(:second_user) {FactoryBot.create(:second_user)}
  let!(:user_profile2) {FactoryBot.create(:user_profile, user_id:second_user.id)}
  let!(:lyric) {FactoryBot.create(:lyric, phrase:'test1', user_id:user.id)}
  let!(:song){FactoryBot.create(:song, lyric_id: lyric.id)}
  let!(:artist){FactoryBot.create(:artist, lyric_id: lyric.id)}
  describe 'コメントCRUD機能' do
    before do
      visit new_user_session_path
      fill_in "user[email]",with: second_user.email
      fill_in "user[password]",with: second_user.password
      click_button "ログイン"
      sleep(3)
    end
    context 'ログインせずに他のユーザーの投稿詳細画面を訪れた場合' do
      it "コメントができない" do
        click_on 'ログアウト'
        visit lyric_path(lyric.id)
        expect(page).to have_content 'ログインするとコメントができます'
        expect(page).to_not have_button 'Comment'
      end
    end
    context 'ログイン後に他のユーザーの投稿詳細画面を訪れた場合' do
      it "コメントが投稿できる" do
        visit lyric_path(lyric.id)
        fill_in 'comment[content]',with: '春夏秋冬'
        click_button 'Comment'
        expect(page).to have_content '春夏秋冬'
      end
    end
    context 'ログインしている場合' do
      it "自分の書いたコメントの編集ができる" do
        visit lyric_path(lyric.id)
        fill_in 'comment[content]',with: '春夏秋冬'
        click_button 'Comment'
        comment_edit_lists = all('.test_edit')
        comment_edit_lists[0].click
        fill_in "comment_content_#{lyric.id}",with: 'All Seasons'
        click_button '更新する'
        expect(page).to_not have_content '春夏秋冬'
        expect(page).to have_content 'All Seasons'
      end
    end
    context 'ログインしている場合' do
      it "自分の書いたコメントの削除ができる" do
        visit lyric_path(lyric.id)
        fill_in 'comment[content]',with: '春夏秋冬'
        click_button 'Comment'  
        page.accept_confirm do
          click_link("test_destroy#{lyric.id}")
        end
        expect(page).to_not have_content '春夏秋冬'
      end
    end
  end
end