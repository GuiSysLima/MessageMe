class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
    
    @private_messages = @conversation.private_messages

    @private_message = PrivateMessage.new
  end

  def create
    @other_user = User.find(params[:friend_id])

    @conversation = Conversation.between(current_user.id, @other_user.id).first
    if @conversation.nil?
      @conversation = Conversation.create(sender: current_user, recipient: @other_user)
    end

    redirect_to conversation_path(@conversation)
  end
end
