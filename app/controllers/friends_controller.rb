class FriendsController < ApplicationController
  before_action only: %i[ show edit update destroy ]

  # GET /friends or /friends.json
  def index
    friend = Friend.where(first_user: current_user.id).where(is_friend: true).pluck(:second_user)+Friend.where(second_user: current_user.id).where(is_friend: true).pluck(:first_user)
    @friends = User.find(friend)
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    notFriends = Friend.where(first_user: current_user.id).pluck(:second_user)+Friend.where(second_user: current_user.id).pluck(:first_user) + [current_user.id]
    @users = User.where.not(id: notFriends).paginate(page: params[:page], per_page: 2)
  end

  # GET /friends/1/edit
  def edit
    @pendingRequests = User.find(Friend.where(second_user: current_user.id).where(is_friend: false).pluck(:first_user))
  end

  # POST /friends or /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    id = params[:id]
    friend = Friend.where(first_user: id, second_user: current_user.id)[0]
    if (friend)
      friend.destroy
    else
      friend = Friend.where(first_user: current_user.id, second_user: id)[0]
      friend.destroy
    end
    byebug
    redirect_to friends_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_friend
    #   @friend = Friend.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.fetch(:friend, {})
    end
end
