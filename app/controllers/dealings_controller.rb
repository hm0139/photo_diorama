class DealingsController < ApplicationController
  def new
    @commission = Commission.find(params[:commission_id])
  end

  def create
    
  end
end
