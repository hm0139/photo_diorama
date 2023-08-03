class ChatsController < ApplicationController
  def create
    @commission = Commission.find(params[:commission_id])
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to commission_dealing_path(@commission,@commission.dealing)
    else
      @chats = Chat.where(dealing_id: @commission.dealing.id).includes(:user)
      render "dealings/show", status: :unprocessable_entity
    end
  end

  private
  def chat_params
    dealing = @commission.dealing
    params.require(:chat).permit(:post_text).merge(user_id: current_user.id, dealing_id: dealing.id)
  end
end
