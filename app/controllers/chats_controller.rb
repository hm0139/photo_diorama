class ChatsController < ApplicationController
  def create
    @commission = Commission.find(params[:commission_id])
    Chat.create(chat_params)
    redirect_to commission_dealing_path(@commission,@commission.dealing)
  end

  private
  def chat_params
    dealing = @commission.dealing
    params.require(:chat).permit(:post_text).merge(user_id: current_user.id, dealing_id: dealing.id)
  end
end
