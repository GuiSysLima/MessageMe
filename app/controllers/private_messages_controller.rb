class PrivateMessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:private_message][:conversation_id])
    @private_message = current_user.private_messages.build(private_message_params)
    
    if @private_message.save
      Turbo::StreamsChannel.broadcast_append_to(
        "chat_#{@conversation.id}",
        target: "private_messages",       
        partial: "private_messages/private_message", 
        locals: { private_message: @private_message }
      )

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
