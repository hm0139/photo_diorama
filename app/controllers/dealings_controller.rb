class DealingsController < ApplicationController
  before_action :redirect_root, except: :show
  before_action :show_redirect_root, only: :show

  def new
    @commission = Commission.find(params[:commission_id])
  end

  def create
    @dealing = Dealing.create(user_id: current_user.id, commission_id: params[:commission_id])
    @commission = @dealing.commission
    if @commission.directly
      @commission.update(status: Commission.statuses[:dealing])
      @commission.notification.destroy
    else
      @commission.update(contractor_id: current_user.id, status: Commission.statuses[:dealing])
    end
    redirect_to commission_dealing_path(@dealing.commission.id,@dealing)
  end

  def show
    @chat = Chat.new
    @chats = Chat.merge(Chat.where(user_id: @commission.contractor_id).or(Chat.where(user_id: @commission.user_id))).where(dealing_id: @commission.dealing.id)
  end

  private
  def redirect_root
    if !user_signed_in? || current_user.kind == 0
      redirect_to root_path
    end
  end

  def show_redirect_root
    @commission = Commission.find(params[:commission_id])
    if !user_signed_in? || current_user.id != @commission.contractor_id && current_user.id != @commission.user_id
      redirect_to root_path
    end
  end
end
