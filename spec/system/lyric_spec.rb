require 'rails_helper'
RSpec.describe '歌詞投稿機能', type: :system do
  let!(:user) { FactoryBot.create(:user,email:'katsuo@example.com')}
  let!(:user_profile) {FactoryBot.create(:user_profile, user_id:user.id)}
  let!(:second_user) {FactoryBot.create(:second_user)}
  let!(:user_profile2) {FactoryBot.create(:user_profile, user_id:second_user.id)}
  let!(:admin_user) {FactoryBot.create(:admin_user)}
  let!(:user_profile3) {FactoryBot.create(:user_profile, user_id:admin_user.id)}
  let!(:lyric) {FactoryBot.create(:lyric, phrase:'test1', user_id:user.id)}
  let!(:song){FactoryBot.create(:song, lyric_id: lyric.id)}
  let!(:artist){FactoryBot.create(:artist, lyric_id: lyric.id)}
  describe 'CRUD機能のテスト' do
    before do
      visit new_user_session_path
      fill_in "user[email]",with: user.email
      fill_in "user[password]",with: user.password
      click_button "ログイン"
      sleep(3)
    end
    context '新規投稿した場合' do
      it '作成した投稿内容が登録される' do
        visit new_lyric_path
        fill_in 'lyric[phrase]', with: '歌詞'
        fill_in 'lyric[detail]', with: '感想'
        fill_in 'lyric[song_attributes][title]', with: 'マリーゴールド'
        fill_in 'lyric[artist_attributes][name]', with: 'あいみょん'
        click_button "投稿する"
        expect(page).to have_content '歌詞'
        expect(page).to have_content '感想'
        expect(page).to have_content 'マリーゴールド'
        expect(page).to have_content 'あいみょん'
      end
    end
    context '詳細画面で編集ボタンを押した場合' do
      it '投稿したユーザーであれば編集できる' do
        visit lyrics_path
        lyric_lists = all('#detail_link')
        lyric_lists[0].click
        sleep(2)
        find("#test_edit").click
        fill_in 'lyric[phrase]', with: '歌詞Change'
        fill_in 'lyric[detail]', with: '感想Change'
        fill_in 'lyric[song_attributes][title]', with: 'HERO'
        fill_in 'lyric[artist_attributes][name]', with: '安室奈美恵'
        click_button "投稿する"
        expect(page).to have_content '歌詞Change'
        expect(page).to have_content '感想Change'
        expect(page).to have_content 'HERO'
        expect(page).to have_content '安室奈美恵'
      end
    end
    context '詳細画面で削除ボタンを押した場合' do
      it '投稿したユーザーであれば削除できる' do
        visit lyrics_path
        lyric_detail_lists = all('#detail_link')
        sleep(1)
        lyric_detail_lists[0].click
        sleep(3)
        page.accept_confirm do
          click_link('test_destroy')
        end
        expect(page).to_not have_content 'test'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:lyric1) {FactoryBot.create(:lyric, phrase:'test2', user_id:user.id)}
    let!(:lyric2) {FactoryBot.create(:lyric, phrase:'test3', user_id:user.id)}
    let!(:song1){FactoryBot.create(:song, lyric_id: lyric1.id)}
    let!(:artist1){FactoryBot.create(:artist, lyric_id: lyric1.id)}
    let!(:song2){FactoryBot.create(:song, lyric_id: lyric2.id)}
    let!(:artist2){FactoryBot.create(:artist, lyric_id: lyric2.id)}

    before do
      visit lyrics_path
    end
    
    context '一覧画面に遷移した場合' do
      it '作成済みの投稿一覧が表示される' do
        expect(page).to have_content 'test2'
        expect(page).to have_content 'test3'
      end
    end
    context '投稿作成日時の降順に並んでいる場合' do
      it '新しい投稿が一番上に表示される' do
        lyric_phrase_lists = all('.lyric_phrase_test')
        expect(lyric_phrase_lists[0]).to have_content 'test3'
        expect(lyric_phrase_lists[1]).to have_content 'test2'
        expect(lyric_phrase_lists[2]).to have_content 'test1'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意の投稿詳細画面に遷移した場合' do
      it '該当の詳細内容が表示される' do
        visit lyric_path(lyric.id)
        expect(page).to have_content lyric.phrase
        expect(page).to have_content lyric.detail
      end
    end
  end
  describe '検索機能' do
    let!(:lyric1) {FactoryBot.create(:lyric, phrase:'test12', user_id:user.id)}
    let!(:lyric2) {FactoryBot.create(:lyric, phrase:'test3', user_id:user.id)}
    let!(:song1){FactoryBot.create(:song, title: 'aaa', lyric_id: lyric1.id)}
    let!(:artist1){FactoryBot.create(:artist, name: 'あああ', lyric_id: lyric1.id)}
    let!(:song2){FactoryBot.create(:song, title: 'bbb', lyric_id: lyric2.id)}
    let!(:artist2){FactoryBot.create(:artist, name: 'いいい', lyric_id: lyric2.id)}
    context '歌詞であいまい検索をした場合' do
      it "検索キーワードの歌詞を含む投稿で絞り込まれる" do
        visit lyrics_path
        fill_in 'q[phrase_cont]', with: 'test1'
        click_button "検索"
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test12'
      end
    end
    context '曲名であいまい検索をした場合' do
      it "検索キーワードの曲名を含む投稿で絞り込まれる" do
        visit lyrics_path
        fill_in 'q[song_title_cont]', with: 'aaa'
        click_button "検索"
        expect(page).to have_content 'aaa'
        expect(page).to_not have_content 'bbb'
      end
    end
    context 'アーティスト名であいまい検索をした場合' do
      it "検索キーワードのアーティスト名を含む投稿で絞り込まれる" do
        visit lyrics_path
        fill_in 'q[artist_name_cont]', with: 'ああ'
        click_button "検索"
        expect(page).to have_content 'あああ'
        expect(page).to_not have_content 'いいい'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:lyric1) {FactoryBot.create(:lyric, phrase:'test2', user_id:user.id)}
    let!(:lyric2) {FactoryBot.create(:lyric, phrase:'test3', user_id:user.id)}
    let!(:song1){FactoryBot.create(:song, lyric_id: lyric1.id)}
    let!(:artist1){FactoryBot.create(:artist, lyric_id: lyric1.id)}
    let!(:song2){FactoryBot.create(:song, lyric_id: lyric2.id)}
    let!(:artist2){FactoryBot.create(:artist, lyric_id: lyric2.id)}

    before do
      visit lyrics_path
    end
    
    context '一覧画面に遷移した場合' do
      it '作成済みの投稿一覧が表示される' do
        expect(page).to have_content 'test2'
        expect(page).to have_content 'test3'
      end
    end
    context '投稿作成日時の降順に並んでいる場合' do
      it '新しい投稿が一番上に表示される' do
        lyric_phrase_lists = all('.lyric_phrase_test')
        expect(lyric_phrase_lists[0]).to have_content 'test3'
        expect(lyric_phrase_lists[1]).to have_content 'test2'
        expect(lyric_phrase_lists[2]).to have_content 'test1'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意の投稿詳細画面に遷移した場合' do
      it '該当の詳細内容が表示される' do
        visit lyric_path(lyric.id)
        expect(page).to have_content lyric.phrase
        expect(page).to have_content lyric.detail
      end
    end
  end
  describe 'お気に入り機能' do
    let!(:lyric1) {FactoryBot.create(:lyric, phrase:'test12', user_id:user.id)}
    let!(:song1){FactoryBot.create(:song, title: 'aaa', lyric_id: lyric1.id)}
    let!(:artist1){FactoryBot.create(:artist, name: 'あああ', lyric_id: lyric1.id)}
    let!(:lyric2) {FactoryBot.create(:lyric, phrase:'test3', user_id:second_user.id)}
    let!(:song2){FactoryBot.create(:song, title: 'bbb', lyric_id: lyric2.id)}
    let!(:artist2){FactoryBot.create(:artist, name: 'いいい', lyric_id: lyric2.id)}
    before do
      visit new_user_session_path
      fill_in "user[email]",with: second_user.email
      fill_in "user[password]",with: second_user.password
      click_button "ログイン"
      sleep(3)
    end
    context '他のユーザーの投稿詳細画面を訪れた場合' do
      it "お気に入りボタンが表示される" do
        visit lyric_path(lyric1.id)
        expect(page).to have_link 'お気に入り'
        expect(page).to_not have_link 'お気に入り解除'
      end
    end
    context '自分の投稿の詳細画面を訪れた場合' do
      it "お気に入りリンクが表示されない" do
        visit lyric_path(lyric2.id)
        expect(page).to_not have_link 'お気に入り'
        expect(page).to_not have_link 'お気に入り解除'
      end
    end
    context 'すでにお気にり済みの他のユーザーの投稿詳細画面を訪れた場合' do
      it "お気に入り解除ボタンが表示される" do
        visit lyric_path(lyric1.id)
        click_on 'お気に入り'
        visit lyric_path(lyric1.id)
        expect(page).to have_link 'お気に入り解除'
      end
    end
    context '他のユーザーの投稿をお気に入り登録した場合' do
      it "お気に入り一覧ページに表示される" do
        visit lyric_path(lyric1.id)
        click_on 'お気に入り'
        visit user_path(second_user.id)
        click_button 'favorites'
        expect(page).to have_content 'aaa'
        expect(page).to have_content 'あああ'
        expect(page).to have_content 'お気に入り一覧'
      end
    end
    context '他のユーザーの投稿をお気に入り解除した場合' do
      it "お気に入り一覧ページに表示されなくなる" do
        visit lyric_path(lyric1.id)
        click_on 'お気に入り'
        visit lyric_path(lyric1.id)
        click_on 'お気に入り解除'
        visit user_path(second_user.id)
        click_button 'favorites'
        expect(page).to_not have_content 'aaa'
        expect(page).to_not have_content 'あああ'
        expect(page).to have_content 'お気に入り一覧'
      end
    end
  end
end