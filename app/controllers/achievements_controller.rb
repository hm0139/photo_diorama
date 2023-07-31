class AchievementsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @achievement = Achievement.new
  end

  def create
  end
end
