class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [:index] 
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @friends = Friend.all
  end

  def show
  end

  def new
    @friend = current_user.friends.build
  end

  def edit
  end

  def create
    @friend = current_user.friends.build(friend_params)

    if @friend.save
      redirect_to @friend, notice: "Friend was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    if @friend.update(friend_params)
      redirect_to @friend, notice: "Friend was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @friend.destroy
    redirect_to friends_url, notice: "Friend was successfully destroyed." 
  end

  def correct_user 
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice: "Not Authorized To Edit This Friend" if @friend.nil?
  end

  private
    def set_friend
      @friend = Friend.find(params[:id])
    end

    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id)
    end
end
