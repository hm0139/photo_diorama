class AchievementsController < ApplicationController
  before_action :redirect_profile

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      redirect_to user_path(@achievement.user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @achievement = @user.achievement
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update(achievement_params)
      redirect_to user_path(@achievement.user)
    else
      render :edit, status: :unprocessable_entity
    end
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
