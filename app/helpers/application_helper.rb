module ApplicationHelper
  def generate_lyric_ranking
    @view_ranking = Lyric.order(views_count: :desc).limit(5)
  end
end
