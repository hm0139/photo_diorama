class EvaluationsController < ApplicationController
  def new
    @commission = Commission.find(params[:commission_id])
    @evaluations = Evaluation.new
  end

  def create
  end
end
