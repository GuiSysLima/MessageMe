class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friend_requests = current_user.friend_requests
    @friends = current_user.accepted_friends
  end

  def search
    if params[:search_term].present?
      @users = User.search(params[:search_term])
      @users = @users.where.not(id: current_user.id)
    else
      @users = []
    end
  end

  def create
    friend_to_add = User.find(params[:friend_id])
    friendship = current_user.friendships.build(friend: friend_to_add, status: 'pending')

    if friendship.save
      flash[:notice] = "Friend request sent to #{friend_to_add.username}!"
      redirect_to search_friends_path
    else
      flash[:alert] = "Unable to add this user as a friend."
      redirect_to search_friends_path
    end

  end

  def update
    friendship = current_user.inverse_friendships.find(params[:id])

    if friendship.update(status: 'accepted')
      flash[:notice] = "You are now friends with #{friendship.user.username}!"
    else
      flash[:alert] = "There was an error.\n Please try again."
    end

    redirect_to my_friends_path
  end
  def destroy
    friendship = current_user.friendship_with(User.find(Friendship.find(params[:id]).friend_id)) || 
                   current_user.friendship_with(User.find(Friendship.find(params[:id]).user_id))
    if friendship.destroy
      flash[:notice] = "#{friendship.friend.username} is no longer your friend."
    else
      flash[:alert] = "There was an error.\n Please try again."
    end

    redirect_to my_friends_path, status: :see_other
  end
end
