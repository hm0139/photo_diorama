class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @achievement = @user.achievement if @user.kind == 1
  end
end
