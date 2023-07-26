class CommissionsController < ApplicationController
  def index
  end

  def new
    @commission = Commission.new
  end
end
