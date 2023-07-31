class DealingsController < ApplicationController
  def new
    @commission = Commission.find(params[:commission_id])
  end

  def create
    @dealing = Dealing.create(user_id: current_user.id, commission_id: params[:commission_id])
    @commission = @dealing.commission
    @commission.update(status: Commission.statuses[:dealing])
    if @commission.directly
      @commission.notification.destroy
    end
    redirect_to commission_dealing_path(@dealing.commission.id,@dealing)
  end
end
