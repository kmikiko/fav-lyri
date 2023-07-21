class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
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
end
