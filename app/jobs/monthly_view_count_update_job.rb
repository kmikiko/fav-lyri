class MonthlyViewCountUpdateJob < ApplicationJob
  queue_as :default

  def perform
    Lyric.update_all(impressions_count: 0)
  end
end
