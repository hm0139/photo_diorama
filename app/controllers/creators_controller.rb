class CreatorsController < ApplicationController
  def index
    user_id = user_signed_in? ? current_user.id : nil
    @creators = User.where(kind: 1).where.not(id: user_id)
  end

  def search
    @creators = User.search(params[:user_name])
  end
end
