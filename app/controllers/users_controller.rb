class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @achievement = @user.achievement if @user.kind == 1
    @commissions = Commission.where(user_id: @user.id).or(Commission.where(contractor_id: @user.id)) if user_signed_in? && current_user.id == @user.id
  end
end
