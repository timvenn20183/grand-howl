class UserMailer < ActionMailer::Base

    default from: "info@grandhowl.co.za"

    def new_user(user)
        @user = user
        mail(to: 'sharon@nevyn.co.za', subject: "New user on GrandHowl")
    end

    def welcome(user)
        @user = user
        mail(to: @user.email, subject: "Welcome to the GrandHowl")
    end

end
