class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where(checked: false).to_a
    @notifications.each do |notification|
      notification.update(checked: true)
    end
  end
end
