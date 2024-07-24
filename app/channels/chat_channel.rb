class ChatChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "connected"
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Rails.logger.info "speak: #{data}"
    ActionCable.server.broadcast("chat_channel", {message: data["message"]})
  end
end