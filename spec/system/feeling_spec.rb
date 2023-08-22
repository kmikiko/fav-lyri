require 'rails_helper'

RSpec.describe '気分ラベル付け機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_profile) {FactoryBot.create(:user_profile, user_id:user.id)}
  let!(:lyric) { FactoryBot.create(:lyric, :with_feeling, user: user, phrase: 'lyric_a')}
  let!(:song){FactoryBot.create(:song, lyric_id: lyric.id)}
  let!(:artist){FactoryBot.create(:artist, lyric_id: lyric.id)}
  describe 'ラベル付け機能' do
    before do
      visit new_user_session_path
      sleep(1)
      fill_in "user[email]",with: user.email
      fill_in "user[password]",with: user.password
      click_button "ログイン"
      sleep(3)
    end
    context '新規作成画面で気分ラベルを登録した場合' do
      it '投稿一覧画面でつけた気分ラベルが表示される' do
        visit new_lyric_path
        fill_in 'lyric[phrase]', with: '歌詞'
        fill_in 'lyric[detail]', with: '感想'
        fill_in 'lyric[song_attributes][title]', with: 'マリーゴールド'
        fill_in 'lyric[artist_attributes][name]', with: 'あいみょん'
        check '悲しい'
        click_button "投稿する"
        lyric_feeling_lists = all('.test_feeling')
        expect(lyric_feeling_lists.first).to have_content '悲しい'
        expect(lyric_feeling_lists.first).to_not have_content '疲れた'
      end
    end
    context '新規作成画面で気分ラベルを複数つけた場合' do
      it 'すべてのラベルが一覧画面に反映される' do
        visit new_lyric_path
        fill_in 'lyric[phrase]', with: '歌詞'
        fill_in 'lyric[detail]', with: '感想'
        fill_in 'lyric[song_attributes][title]', with: 'マリーゴールド'
        fill_in 'lyric[artist_attributes][name]', with: 'あいみょん'
        check '悲しい'
        check '嬉しい'
        click_button "投稿する"
        lyric_feeling_lists = all('.test_feeling')
        expect(lyric_feeling_lists.first).to have_content '悲しい'
        expect(lyric_feeling_lists.first).to have_content '嬉しい'
        expect(lyric_feeling_lists.first).to_not have_content '疲れた'
      end
    end
  end

  describe '編集機能' do
    before do
      visit new_user_session_path
      fill_in "user[email]",with: user.email
      fill_in "user[password]",with: user.password
      click_button "ログイン"
      sleep(1)
    end
    context '編集画面でラベルを編集した場合' do
      it '一覧画面に変更内容が反映される' do
        visit lyrics_path
        lyric_lists = all('#detail_link')
        lyric_lists[0].click
        sleep(1)
        find("#test_edit").click
        check '疲れた'
        click_button "投稿する"
        lyric_feeling_lists = all('.test_feeling')
        expect(lyric_feeling_lists.first).to have_content '悲しい'
        expect(lyric_feeling_lists.first).to_not have_content '嬉しい'
        expect(lyric_feeling_lists.first).to have_content '疲れた'
      end
    end
  end

  describe '詳細表示機能' do
    context '詳細画面に遷移した場合' do
      it '紐づいている気分ラベルが表示される' do
        visit lyrics_path
        lyric_lists = all('#detail_link')
        lyric_lists[0].click
        sleep(1)
        expect(page).to_not have_content '嬉しい'
        expect(page).to_not have_content '疲れた'
        expect(page).to have_content '悲しい'
      end
    end
  end

  describe 'ラベル検索機能' do
    before do
      lyric1 = FactoryBot.create(:lyric, :with_feeling, user: user, phrase: 'first')
      FactoryBot.create(:song, lyric_id: lyric1.id)
      FactoryBot.create(:artist, lyric_id: lyric1.id)
      lyric2 = FactoryBot.create(:lyric, :with_feeling2, user: user, phrase: 'second')
      FactoryBot.create(:song, lyric_id: lyric2.id)
      FactoryBot.create(:artist, lyric_id: lyric2.id)
      lyric3 = FactoryBot.create(:lyric, :with_feeling3, user: user, phrase: 'third')
      FactoryBot.create(:song, lyric_id: lyric3.id)
      FactoryBot.create(:artist, lyric_id: lyric3.id)
    end
    context '一覧画面でラベルを選択し検索した場合' do
      it '指定したラベルがついた投稿のみが表示される' do
        visit lyrics_path
        select '悲しい', from: 'q[feelings_id_eq]'
        click_button "検索"
        lyric_feeling_lists = all('.test_feeling')
        expect(lyric_feeling_lists[0]).to have_content '悲しい'
        expect(lyric_feeling_lists[1]).to have_content '悲しい'
        expect('page').to_not have_content '嬉しい'
        expect('page').to_not have_content '疲れた'
      end
    end
  end
end