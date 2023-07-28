class CreatorsController < ApplicationController
  def index
    @creators = User.where(kind: 1)
    @commission = Commission.find(params[:id])
  end
end
