class MonthlyViewCountUpdateJob < ApplicationJob
  queue_as :default

  def perform
    Lyric.where('created_at < ?', 1.month.ago).update_all(impressions_count: 0)
  end
end
