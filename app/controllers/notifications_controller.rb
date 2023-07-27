class NotificationsController < ApplicationController
  def index
    @commissions = Commission.where(directly: true).where(contractor_id: current_user.id)
  end
end
