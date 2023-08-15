class EvaluationsController < ApplicationController
  def new
    @commission = Commission.find(params[:commission_id])
    @evaluation = Evaluation.new
  end

  def create
    @commission = Commission.find(params[:commission_id])
    @evaluation = Evaluation.new(evaluation_params)
    if @evaluation.save
      @commission.update_attribute(:status, Commission.statuses[:finished])
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def evaluation_params
    target_user_id = current_user.kind == 0 ? @commission.contractor_id : @commission.user_id
    params.require(:evaluation).permit(:rank, :comment).merge(commission_id: @commission.id, source_user_id: current_user.id, target_user_id: target_user_id)
  end
end
