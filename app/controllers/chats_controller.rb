class ChatsController < ApplicationController
  def create
    @commission = Commission.find(params[:commission_id])
    @chat = Chat.new(chat_params)
    @chats = Chat.where(dealing_id: @commission.dealing.id).includes(:user).with_attached_images
    if @chat.save
      redirect_to commission_dealing_path(@commission,@commission.dealing)
    else
      render "dealings/show", status: :unprocessable_entity
    end
  end

  private
  def chat_params
    dealing = @commission.dealing
    params.require(:chat).permit(:post_text, images: []).merge(user_id: current_user.id, dealing_id: dealing.id)
  end
end
