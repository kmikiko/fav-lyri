class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy index]
  before_action :set_lyric, only: %i[create destroy index]
  def index
    @favorites = @lyric.favorites
    @favorite_count = @favorites.where(lyric_id: @lyric.id).group(:lyric_id).count
  end
  
  def create
    unless current_user.favorites.exists?(lyric: @lyric)
      @favorite = current_user.favorites.create(lyric_id: params[:lyric_id])
      @lyric.create_notification_favorite!(current_user)
      update_favorite_count
    end  
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id]).destroy
    update_favorite_count
  end

  private

  def set_lyric
    @lyric = Lyric.find(params[:lyric_id])
  end

  def update_favorite_count
    @favorite_count = Favorite.where(lyric_id: @lyric.id).group(:lyric_id).count
  end
end
