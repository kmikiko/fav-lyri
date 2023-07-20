class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(lyric_id: params[:lyric_id])
    # render json: { message: 'お気に入りに登録しました' }, status: :created
    redirect_to lyrics_path, notice: "#{favorite.lyric.user.user_profile.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to lyrics_path, notice: "#{favorite.lyric.user.user_profile.name}さんの投稿をお気に入り解除しました"
  end
end
