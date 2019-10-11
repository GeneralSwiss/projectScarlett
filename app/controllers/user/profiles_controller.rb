class User::ProfilesController < ApplicationController
    # before_action :authenticate_user!, on: :create
    # before_action :require_authorized_for_user_profile, on: :create

    def new
        @profile = Profile.new
    end

    def create
        @profile = current_user.profile.create(profile_params)
        # redirect_to user_profile_path(user_profile)
    end

    def show
        @profile = Profile.find(params[:id])
    end

    private

    def require_authorized_for_user_profile
        if user_profile.user != current_user
            render plain: "Unauthorized", status: :unauthorized
        end
    end

    helper_method :user_profile
    def user_profile
        @user_profile ||= Profile.find(params[:profile_id])
    end

    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :nickname, :age, :sex)
    end
end
