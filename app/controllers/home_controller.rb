class HomeController < ApplicationController
    def index
        if(!current_user)
            redirect_to new_user_session_path
            return
        end
        @post = Post.all
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
