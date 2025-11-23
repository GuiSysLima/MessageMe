class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :username, presence: true, length: { minimum: 3, maximum: 15}, 
    uniqueness: { case_sensitive: false}
    
  has_many :messages
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :friends, -> { where(friendships: { status: :accepted }) },
           through: :friendships
  has_many :inverse_friends, -> { where(friendships: { status: :accepted }) },
           through: :inverse_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { status: :pending }) },
           through: :friendships, source: :friend
  has_many :friend_requests, -> { where(friendships: { status: :pending }) },
           through: :inverse_friendships, source: :user
  
  has_many :conversations_as_sender,
           class_name: 'Conversation',
           foreign_key: 'sender_id',
           dependent: :destroy       
  has_many :conversations_as_recipient,
           class_name: 'Conversation',
           foreign_key: 'recipient_id',
           dependent: :destroy
  has_many :private_messages, dependent: :destroy

  def conversations
    conversations_as_sender.or(conversations_as_recipient)
  end

  def accepted_friends
    (friends + inverse_friends).uniq
  end

  def friendship_with(user)
    friendships.find_by(friend: user) || inverse_friendships.find_by(user: user)
  end

  def friend_with?(user)
    accepted_friends.include?(user)
  end

  def self.search(term)
    return [] if term.blank?
    
    term = term.downcase
    where("lower(username) LIKE :term OR lower(email) LIKE :term", term: "%#{term}%")
  end

end
