class EvaluationsController < ApplicationController
  def new
    @commission = Commission.find(params[:commission_id])
    @evaluation = Evaluation.new
  end

  def create
  end
end
