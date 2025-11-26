class PagesController < ApplicationController
  def home
    if user_signed_in?
      @conversations = current_user.conversations.includes(:sender, :recipient)
      @friends = current_user.accepted_friends
    else
      @conversations = []
      @friends = []
    end
  end
end
