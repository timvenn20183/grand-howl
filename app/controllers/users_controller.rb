class UsersController < ApplicationController

    layout 'admin'
    before_filter :authenticate_admin, :only => [:disable]
    before_filter :authenticate_user, :only => [:options_update]


    def disable
        user = User.find((params[:user_id]))
        user.active = !user.active
        user.save
        render :nothing => true
    end

    def options_update
        render :nothing => true
    end

end
