class EvaluationsController < ApplicationController
  before_action :permission

  def new
    @evaluation = Evaluation.new
  end

  def create
    @evaluation = Evaluation.new(evaluation_params)
    if @evaluation.save
      partner_id = current_user.id == @commission.user_id ? @commission.contractor_id : @commission.user_id

      if Evaluation.existence_evaluation? partner_id, @commission.id
        @commission.update_attribute(:status, Commission.statuses[:finished])
        Evaluation.update_rank(@evaluation.target_user_id)
      end
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def evaluation_params
    target_user_id = current_user.id == @commission.user_id ? @commission.contractor_id : @commission.user_id
    params.require(:evaluation).permit(:rank, :comment).merge(commission_id: @commission.id, source_user_id: current_user.id, target_user_id: target_user_id)
  end

  def permission
    return redirect_to root_path unless user_signed_in?

    @commission = Commission.find(params[:commission_id])
    unless @commission.waiting_evaluation? && !Evaluation.existence_evaluation?(current_user.id, @commission.id) && (current_user.id == @commission.user_id || current_user.id == @commission.contractor_id)
      redirect_to user_path(current_user)
    end
  end
end
