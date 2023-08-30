class ChatChannel < ApplicationCable::Channel
  def subscribed
    @user = User.find(params[:user_id])
    reject if @user.nil?
    @room = Dealing.find(params[:room_id])
    refect if @room.nil?

    stream_from "chat_channel_#{@room.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(data)
    Chat.create!(post_text: data["message"], user_id: @user.id, dealing_id: @room.id, images: [])
  end
end
