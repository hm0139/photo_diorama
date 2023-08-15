class DealingsController < ApplicationController
  before_action :redirect_root, only: [:new, :create]
  before_action :show_redirect_root, only: [:show, :destroy]

  def new
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
    @chats = Chat.where(dealing_id: @commission.dealing.id).includes(:user).with_attached_images
    gon.file_limit = Chat::FILE_NUMBER_LIMIT
  end

  def destroy
    commission = Commission.find(params[:commission_id])
    #期限日が7以内だった場合に、バリデーションに引っかかってしまうので以下のメソッドを使用してバリデーションを無視
    commission.update_attribute(:status, Commission.statuses[:waiting_evaluation])
    redirect_to commission_dealing_path(commission, commission.dealing)
  end

  private
  def redirect_root
    @commission = Commission.find(params[:commission_id])
    if !user_signed_in? || current_user.kind == 0 || (@commission.limit_date - Date.today) < Commission::DEADLINE_DAYS
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
