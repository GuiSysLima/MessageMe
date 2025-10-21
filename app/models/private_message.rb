class PrivateMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  after_create_commit { broadcast_append_to [conversation, "messages"], partial: "private_messages/private_message" }
end
