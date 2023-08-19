class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy index]
  before_action :set_lyric, only: %i[create destroy index]
  def index
    @favorites = @lyric.favorites
    @favorite_count = @favorites.where(lyric_id: @lyric.map(&:id)).group(:lyric_id).count
  end
  
  def create
    @favorite = current_user.favorites.create(lyric_id: params[:lyric_id])
    @lyric.create_notification_favorite!(current_user)
    @favorite_count = @favorite_count = Favorite.where(lyric_id: @lyric.id).group(:lyric_id).count
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id]).destroy
    @favorite_count = @favorite_count = Favorite.where(lyric_id: @lyric.id).group(:lyric_id).count
  end

  private

  def set_lyric
    @lyric = Lyric.find(params[:lyric_id])
  end
end
