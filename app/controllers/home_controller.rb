class HomeController < ActionController::Base
    def index
        if(!current_user)
            redirect_to new_user_session_path
        end
        @post = Post.all
        @users = User.all
    end
end
