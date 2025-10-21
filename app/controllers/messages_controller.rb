class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      redirect_to chatroom_path
    else
      flash[:alert] = "Message could not be sent."
      redirect_to chatroom_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end