class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  respond_to? :js 
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
