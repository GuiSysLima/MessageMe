class PrivateMessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:private_message][:conversation_id])

    unless @conversation.sender == current_user || @conversation.recipient == current_user
      flash[:alert] = "You are not authorized to view this page."
      redirect_to root_path
      return
    end

    @private_message = current_user.private_messages.build(private_message_params)
    
    if @private_message.save
      redirect_to conversation_path(@conversation)
    else
      flash[:alert] = "Message could not be sent."
      redirect_to conversation_path(@conversation)
    end
  end

  private

  def private_message_params
    params.require(:private_message).permit(:body, :conversation_id)
  end
end
