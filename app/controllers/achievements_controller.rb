class AchievementsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @achievement = Achievement.new
  end

  def create
    achievement = Achievement.create(achievement_params)
    redirect_to user_path(achievement.user)
  end

  private
  def achievement_params
    params.require(:achievement).permit(:achievement_text, :text, images: []).merge(user_id: current_user.id)
  end
end
