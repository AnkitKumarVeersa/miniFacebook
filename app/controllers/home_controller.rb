class HomeController < ActionController::Base
    def index
        if(!current_user)
            redirect_to new_user_session_path
            return
        end
        @post = Post.all
        notFriends = Friend.where(first_user: current_user.id).pluck(:second_user)+Friend.where(second_user: current_user.id).pluck(:first_user) + [current_user.id]
        @pendingRequests = User.find(Friend.where(second_user: current_user.id).where(is_friend: false).pluck(:first_user))
        friend = Friend.where(first_user: current_user.id).where(is_friend: true).pluck(:second_user)+Friend.where(second_user: current_user.id).where(is_friend: true).pluck(:first_user)
        @friends = User.find(friend)
        @users = User.where.not(id: notFriends)
    end

    def sendRequest
        id = params[:id]
        user = User.find(id)
        friend= Friend.new(first_user: current_user.id, second_user: posts_params[:id], is_friend: false)
        friend.save
        redirect_to root_url
    end

    def acceptRequest
        friend = Friend.where(first_user: params[:id], second_user: current_user.id)[0]
        if(params[:accept] == "1")
            friend.update(is_friend: true)
        else
            friend.destroy
        end
        redirect_to root_url
    end

    private 
    def posts_params
    params.permit(:id)
    end
end
