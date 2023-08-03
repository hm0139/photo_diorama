class DealingsController < ApplicationController
  before_action :redirect_root, except: :show

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

  def show
    @chat = Chat.new
    @commission = Commission.find(params[:commission_id])
    @chats = Chat.merge(Chat.where(user_id: @commission.dealing.user_id).or(Chat.where(user_id: @commission.user_id))).where(dealing_id: @commission.dealing.id)
  end

  private
  def redirect_root
    if !user_signed_in? || current_user.kind == 0
      redirect_to root_path
    end
  end
end
