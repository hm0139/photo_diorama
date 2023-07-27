class CreatorsController < ApplicationController
  def index
    @creators = User.all
    @commission = Commission.find(params[:id])
  end
end
