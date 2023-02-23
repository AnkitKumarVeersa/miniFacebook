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
        byebug
        redirect_to root_url
    end
end
