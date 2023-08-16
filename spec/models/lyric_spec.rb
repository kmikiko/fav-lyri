require 'rails_helper'

RSpec.describe Lyric, type: :model do
  describe 'バリデーションのテスト' do
    context 'phraseが空の場合' do
      it 'バリデーションに失敗すること' do
        lyric = Lyric.new(phrase: '', detail: 'テスト詳細', user_id: 1)
        expect(lyric).not_to be_valid
      end
    end
    context 'phraseが1文字以上入力されている場合' do
      it 'バリデーションに成功すること' do
        lyric = Lyric.create(phrase: 'a', detail: 'テスト詳細', user_id: 1)
        expect(lyric).to be_valid
      end
    end
    context 'phraseが20文字を超える場合' do
      it 'バリデーションに失敗すること' do
        long_phrase = 'a' * 21
        lyric = Lyric.new(phrase: long_phrase, detail: 'テスト詳細', user_id: 1)
        expect(lyric).not_to be_valid
      end
    end
    context 'detailが空の場合' do
      it 'バリデーションに失敗すること' do
        lyric = Lyric.new(phrase: 'テスト', detail: '', user_id: 1)
        expect(lyric).not_to be_valid
      end
    end
  end
  describe 'スコープのテスト' do
    describe '.recently_created' do
      it '1か月以内に作成された歌詞を取得すること' do
        user = User.create!(email: 'test@sample.com', password: 'password')
        recent_lyric = Lyric.create!(created_at: 2.weeks.ago, phrase: 'test', detail: 'test', user_id: user.id, id: 1)
        old_lyric = Lyric.create!(created_at: 2.months.ago, phrase: 'test', detail: 'test', user_id: user.id, id: 2)
        expect(Lyric.recently_created).to include(recent_lyric)
        expect(Lyric.recently_created).not_to include(old_lyric)
      end
    end

    describe '.ranked' do
      it '閲覧数昇順で歌詞を並び替えること' do
        most_viewed_lyric = Lyric.create(impressions_count: 100, phrase: 'test', detail: 'test', user_id: 1, id: 1)
        less_viewed_lyric = Lyric.create(impressions_count: 50, phrase: 'test', detail: 'test', user_id: 1, id: 2)
        ranked_lyrics = Lyric.ranked
        expect(ranked_lyrics.first).to eq(most_viewed_lyric)
        expect(ranked_lyrics.last).to eq(less_viewed_lyric)
      end
    end
  end

  describe 'メソッドのテスト' do
    describe 'create_notification_favorite!メソッド' do
      it 'いいね通知が正しく作成されること' do
        user = User.create(email: 'test@sample.com', password: 'password')
        other_user = User.create(email: 'test2@sample.com', password: 'password')
        lyric = FactoryBot.create(:lyric, user_id: other_user.id)
        user.create_notification_favorite!(lyric)

        expect(Notification.last.action).to eq('like')
        expect(Notification.last.visitor_id).to eq(user.id)
        expect(Notification.last.visited_id).to eq(other_user.id)
        expect(Notification.last.lyric_id).to eq(lyric.id)
      end
    end

    describe 'create_notification_comment!メソッド' do
      it 'コメント通知が正しく作成されること' do
        user = User.create(email: 'test@sample.com', password: 'password')
        lyric = FactoryBot.create(:lyric, user_id: user.id)
        comment = Comment.create(user_id: user.id, lyric_id: lyric.id)
        
        other_user = User.create(email: 'test2@sample.com', password: 'password')
        lyric.create_notification_comment!(user, comment.id)

        expect(Notification.last.action).to eq('comment')
        expect(Notification.last.visitor_id).to eq(user.id)
        expect(Notification.last.visited_id).to eq(other_user.id)
        expect(Notification.last.lyric_id).to eq(lyric.id)
        expect(Notification.last.comment_id).to eq(comment.id)
      end
    end
  end
end