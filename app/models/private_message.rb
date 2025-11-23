class PrivateMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  encrypts :body

  after_create_commit { broadcast_append_to "chat_#{conversation.id.to_s}", target: "private_messages" }
end
