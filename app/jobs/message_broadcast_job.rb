class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast("chat_channel_#{data.dealing_id}", {message: render_message(data)})
  end

  private
  def render_message(message)
    ApplicationController.renderer.render(json:{id: message.id})
  end
end
