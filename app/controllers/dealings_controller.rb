class DealingsController < ApplicationController
  def new
    @commission = Commission.find(params[:commission_id])
  end

  def create
    @dealing = Dealing.create(status: 0, user_id: current_user.id, commission_id: params[:commission_id])
    redirect_to commission_dealing_path(@dealing.commission.id,@dealing)
  end
end
