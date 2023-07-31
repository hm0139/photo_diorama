class AchievementsController < ApplicationController
  before_action :redirect_profile, only:[:new, :edit]

  def new
    @achievement = Achievement.new
  end

  def create
    achievement = Achievement.create(achievement_params)
    redirect_to user_path(achievement.user)
  end

  def edit
    @achievement = @user.achievement
  end

  def update
    achievement = Achievement.find(params[:id])
    achievement.update(achievement_params)
    redirect_to user_path(achievement.user)
  end

  private
  def achievement_params
    params.require(:achievement).permit(:achievement_text, :text, images: []).merge(user_id: current_user.id)
  end

  def redirect_profile
    @user = User.find(params[:user_id])
    unless user_signed_in? && current_user.id == @user.id && @user.kind == 1
      redirect_to user_path(@user)
    end
  end
end
