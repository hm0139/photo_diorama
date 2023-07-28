class NotificationsController < ApplicationController
  def index
    @commissions = Commission.where(directly: true).where(contractor_id: current_user.id).where(status: Commission.statuses[:undealt])
  end
end
