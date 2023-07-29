class NotificationsController < ApplicationController
  def index
    @commissions = Commission.where(directly: true).where(contractor_id: current_user.id).where(status: Commission.statuses[:undealt])
  end

  def destroy
    notification = Notification.find(params[:id])
    commission = notification.commission
    commission.update(status: Commission.statuses[:unsuccessful])
    notification.destroy
    redirect_to root_path, flash: {unsuccessful: "依頼を断りました"}
  end
end
