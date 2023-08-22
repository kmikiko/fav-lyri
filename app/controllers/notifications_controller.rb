class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  def index
    @notifications = current_user.passive_notifications.to_a
    @notifications.each do |notification|
      notification.update(checked: true)
    end
  end
end
