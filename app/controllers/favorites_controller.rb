class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_lyric, only: %i[create destroy]
  def create
    @favorite = current_user.favorites.create(lyric_id: params[:lyric_id])
    @lyric.create_notification_favorite!(current_user)
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id]).destroy
  end

  private

  def set_lyric
    @lyric = Lyric.find(params[:lyric_id])
  end
end
