class CommissionsController < ApplicationController
  before_action :direct_commission, only: [:show]
  before_action :redirect_root, only:[:select, :selected_confirmation, :direct, :delete_confirmation, :destroy]

  def index
    @commissions = Commission.where(directly: false).where(status: Commission.statuses[:undealt]).includes(:user)
    session[:return_to_page] = "トップページに戻る"
    session[:previous_url] = request.url
  end

  def new
    @commission = Commission.new
  end

  def create
    @commission = Commission.new(commission_param)
    if @commission.save
      if @commission.directly
        redirect_to select_commission_path(@commission)
      else
        redirect_to commission_path(@commission)
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def select
    @creators = User.where(kind: 1).where.not(id: current_user.id)
  end

  def selected_confirmation
    @creator = User.find(params[:user_id])
  end

  def direct
    creator = User.find(params[:user_id])
    @commission.contractor_id = creator.id
    @commission.save
    Notification.create(user_id: creator.id, commission_id: @commission.id)
    redirect_to commission_path(@commission), flash: {direcly: "#{creator.user_name}さんに依頼しました"}
  end

  def unsuccessful
    @commission = Commission.find(params[:id])
  end

  def search
    @keyword = params[:keyword]
    @commissions = Commission.search(@keyword, params[:reward_lower], params[:reward_upper], params[:limit_days]).includes(:user)
    @count = @commissions.count
  end

  def delete_confirmation
    @commission = Commission.find(params[:id])
  end

  def destroy
    commission = Commission.find(params[:id])
    commission.destroy
    redirect_to root_path, flash: {deleted: "依頼を削除しました"}
  end

  private
  def commission_param
    params.require(:commission).permit(:title, :description, :limit_date, :reward, :directly, :contractor).merge(user_id: current_user.id)
  end

  def direct_commission
    @commission = Commission.find(params[:id])
    if @commission.directly && (!user_signed_in? || @commission.contractor_id != current_user.id && @commission.user_id != current_user.id)
      redirect_to root_path
    end
  end

  def redirect_root
    @commission = Commission.find(params[:id])
    if !user_signed_in? || @commission.user_id != current_user.id
      redirect_to root_path
    end
  end
end
