class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show_favorites, :show_followers, :show_following]
  def show
    @user = User.find(params[:id]) 
    following_users = @user.following + [@user]
    @following_lyrics = Lyric.where(user_id: following_users).order(created_at: :desc)
  end

  def show_favorites
    @favorites = current_user.favorites.order(created_at: :desc)
  end

  def show_followers
    @user = User.find(params[:id])
    @followers = @user.followers.all
  end

  def show_following
    @user = User.find(params[:id]) 
    @following = @user.following.all
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to lyrics_path, notice: "ゲストユーザーとしてログインしました"
  end

  def guest_admin_sign_in
    user = User.guest_admin
    sign_in user
    redirect_to lyrics_path, notice: 'ゲストユーザー（管理者）としてログインしました'
  end
  
end
