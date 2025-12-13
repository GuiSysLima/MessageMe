class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  enum status: { pending: 'pending', accepted: 'accepted' }

  after_commit :update_friend_badge

  private

  def update_friend_badge

    broadcast_replace_to(
      "user_#{friend.id}_notifications", 
      target: "navbar_notifications", 
      partial: "layouts/friend_requests_badge", 
      locals: { user: friend }
    )
    
    if saved_change_to_id?
      broadcast_prepend_to(
        "user_#{friend.id}_notifications",
        target: "pending_requests",
        partial: "friendships/request",
        locals: { user: user, friendship: self }
      )
    end
  end
end