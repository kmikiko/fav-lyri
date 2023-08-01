class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
    @following_lyrics = @user.following.map { |user| user.lyrics }.flatten.sort_by(&:created_at).reverse
  end

  def show_favorites
    @favorites = current_user.favorites
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
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end

  def guest_admin_sign_in
    user = User.guest_admin
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザー（管理者）としてログインしました'
  end
  
end
