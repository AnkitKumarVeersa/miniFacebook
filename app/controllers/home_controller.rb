class HomeController < ActionController::Base
    def index
        if(!current_user)
            redirect_to new_user_session_path
        end
        @post = Post.all
        @users = User.all
    end

    def sendRequest
        id = params[:id]
        user = User.find(id)
        friend= Friend.new(first_user: current_user.id, second_user: posts_params[:id], is_friend: false)
        friend.save
        redirect_to root_url
    end

    private 
    def posts_params
    params.permit(:id)
    end
end
