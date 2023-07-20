class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
  end

  def show_favorites
    @favorites = current_user.favorites
  end
end
