require 'rails_helper'
RSpec.describe '歌詞投稿機能', type: :system do
  let!(:user) { FactoryBot.create(:user,email:'katsuo@example.com') }
  let!(:user_profile) {FactoryBot.create(:user_profile, user_id:user.id)}
  let!(:second_user) {FactoryBot.create(:second_user)}
  let!(:user_profile2) {FactoryBot.create(:user_profile, user_id:second_user.id)}
  let!(:admin_user) {FactoryBot.create(:admin_user)}
  let!(:user_profile3) {FactoryBot.create(:user_profile, user_id:admin_user.id)}
  let!(:lyric) {FactoryBot.create(:lyric, phrase:'test', user_id:user.id)}
  let!(:song){FactoryBot.create(:song, lyric_id: lyric.id)}
  let!(:artist){FactoryBot.create(:artist, lyric_id: lyric.id)}
  before do
    visit new_user_session_path
    fill_in "user[email]",with: user.email
    fill_in "user[password]",with: user.password
    click_button "ログイン"
    sleep(3)
  end
  describe '新規作成機能' do
    context '新規投稿した場合' do
      it '作成した投稿内容が登録される' do
        visit new_task_path
        fill_in 'task[name]', with: '洗濯'
        fill_in 'task[detail]', with: 'シーツを洗う'
        select '2023', from: 'task_expired_at_1i'
        select '10月', from: 'task_expired_at_2i'
        select '1', from: 'task_expired_at_3i'
        select '完了', from: 'task_status'
        click_on "登録"
        expect(page).to have_content '洗濯'
        expect(page).to have_content 'シーツを洗う'
        expect(page).to have_content '2023-10-01'
        expect(page).to have_content '完了'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      @task1 = FactoryBot.create(:task, user: user, name: 'bbb', expired_at: '002024-08-06', priority: 1)
      @task2 = FactoryBot.create(:task, user: user, name: 'ccc', expired_at: '002024-07-06', priority: 2)
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みの投稿一覧が表示される' do
        expect(page).to have_content 'bbb'
        expect(page).to have_content 'ccc'
      end
    end
    context '投稿作成日時の降順に並んでいる場合' do
      it '新しい投稿が一番上に表示される' do
        # expect(page.text).to match(/#{@task1.name}[\s\S]*#{task.name}/)
        task_lists = all('.task_name')
        expect(task_lists[0]).to have_content 'ccc'
        expect(task_lists[1]).to have_content 'bbb'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意の投稿詳細画面に遷移した場合' do
      it '該当の詳細内容が表示される' do
        task = FactoryBot.create(:task, user: user)
        visit task_path(task.id)
        expect(page).to have_content task.name
        expect(page).to have_content task.detail
      end
    end
  end
  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, user: user, name: "task", status:"完了")
      FactoryBot.create(:task, user: user, name: "sample", status:"完了")
      FactoryBot.create(:task, user: user, name: "task2", status:"着手前")
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task[keyword]', with: 'tas'
        click_on "検索"
        expect(page).to have_content 'task'
        expect(page).to have_content 'task2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '完了', from: 'task_status'
        click_on "検索"
        sleep(2)
        expect(page).to have_content 'task'
        expect(page).to_not have_content 'task2'
        expect(page).to have_content 'sample'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'task[keyword]', with: 'tas'
        select '完了', from: 'task_status'
        click_on "検索"
        sleep(2)
        task_status_lists = all('.task_status')
        expect(task_status_lists).to_not have_content '未着手'
        expect(page).to have_content 'task'
        expect(page).to_not have_content 'task2'
      end
    end
  end
end