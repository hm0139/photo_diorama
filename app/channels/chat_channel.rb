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
    ActionCable.server.broadcast("chat_channel_#{@room.id}", {message: data["message"]})
  end
end
