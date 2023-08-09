class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    favorite = current_user.favorites.create(lyric_id: params[:lyric_id])
    lyric = Lyric.find(params[:lyric_id])
    lyric.create_notification_favorite!(current_user)
    redirect_to lyrics_path, notice: "#{favorite.lyric.user.user_profile.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to lyrics_path, notice: "#{favorite.lyric.user.user_profile.name}さんの投稿をお気に入り解除しました"
  end
end
