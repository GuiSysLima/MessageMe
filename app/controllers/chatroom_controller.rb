class ChatroomController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations.includes(:sender, :recipient)
    @friends = current_user.accepted_friends
  end


end