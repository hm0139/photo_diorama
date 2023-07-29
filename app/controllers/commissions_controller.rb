class CommissionsController < ApplicationController
  before_action :direct_commission, only: [:show]

  def index
    @commissions = Commission.where(directly: false).where(status: Commission.statuses[:undealt])
  end

  def new
    @commission = Commission.new
  end

  def create
    @commission = Commission.new(commission_param)
    if @commission.save
      if @commission.directly
        redirect_to controller: :creators, action: :index, params: {"id" => @commission.id}
      else
        redirect_to root_path
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def direct
    commission = Commission.find(params[:id])
    creator = User.find(params[:user_id])
    commission.contractor_id = creator.id
    commission.save
    Notification.create(user_id: creator.id, commission_id: commission.id)
    redirect_to root_path
  end

  def unsuccessful
    @commission = Commission.find(params[:id])
  end

  private
  def commission_param
    params.require(:commission).permit(:title, :description, :limit_date, :reward, :directly, :contractor).merge(user_id: current_user.id)
  end

  def direct_commission
    @commission = Commission.find(params[:id])
    if @commission.directly && (!user_signed_in? || @commission.contractor_id != current_user.id)
      redirect_to root_path
    end
  end
end
