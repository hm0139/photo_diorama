class CreatorsController < ApplicationController
  def index
    user_id = user_signed_in? ? current_user.id : nil
    @creators = User.where(kind: 1).where.not(id: user_id)
    @commission = Commission.find(params[:id]) if params.has_key?(:id)
  end
end
