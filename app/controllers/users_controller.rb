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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), flash: {user_update: "ユーザ情報を更新しました"}
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :name, :reading_name, :postal_code, :prefectures, :city, :building_name, :kind, :financial_institution, :branch, :deposit, :account_number, :account_holder)
  end
end
