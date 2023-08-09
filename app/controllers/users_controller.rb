class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @achievement = @user.achievement if @user.kind == 1
    
    if user_signed_in? && current_user.id == @user.id
      @commissions = Commission.where(user_id: @user.id).or(Commission.where(contractor_id: @user.id))
      @commissions_dealing = @commissions.where(status: Commission.statuses[:dealing])
      @commissions_finished = @commissions.where(status: Commission.statuses[:finished])
      @commissions_waiting = @commissions.where(status: Commission.statuses[:undealt])
      @commissions_unsuccessful = @commissions.where(status: Commission.statuses[:unsuccessful])
    end
  end
end
