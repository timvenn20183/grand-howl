class MainController < ApplicationController

	layout :select_layout

	before_filter :authenticate_user, :only => [:myentries, :updates, :myprograms, :mysettings, :myvenues]

 	def select_layout
        if action_name == 'print'
            return 'print'
        else
            return 'main'
        end
  	end

	def index
		@featured = Entry.featured
		@recent = Entry.recent
		@popular = Entry.popular
	end

	def login
	end

	def loginprocess
		user = User.where(:email => params[:email], :pass => params[:password], :active => true, :activation => nil).first

		session[:user] = user.id if !user.blank?
        session[:view_style] = user.options[:view_style] if !user.blank?
        session[:program] = user.options[:program] if !user.blank?

		redirect_to '/' if !user.blank?

		session[:user] = nil if user.blank?
		redirect_to '/login' if user.blank?
	end

    def register
        @user = User.new
    end

	def registerprocess
		@pass = params[:password]
		@cpass = params[:confirmpassword]
		@name = params[:name]
		@email = params[:email]
        @group = params[:group]
		# do the passwords match
#		redirect_to '/register' if @pass != @cpass


	    @user = User.new
	    @user.pass = @pass
		@user.email = @email
		@user.name = @name
        @user.group = @group
		@user.active = true
		@user.level = 0
		if @user.save then
		    session[:user] = @user.id
    		redirect_to '/welcome'
        else
            render :action => 'register'
        end

	end

	def logout
		session[:user] = nil
        clear_current_program
        session[:view_style] = nil
		redirect_to '/'
	end

	def contact
	end

    def process_contact
    	@comment = Comment.create(:name => params[:name], :email => params[:email], :subject => params[:subject], :message => params[:message])
		redirect_to '/contact' if @comment.blank?
		redirect_to '/contact_success' if !@comment.blank?
    end

    def contact_success
    end

    def print
    	@entry = Entry.find_by_slug(params[:id])
  	end

    def entry_comment
        @comment = Comment.new
        @comment.user = current_user
        @entry =  Entry.find_by_slug(params[:entry_slug])
        @comment.entry = @entry
        @comment.message = params[:message]
        @comment.save
        respond_to do |format|
                format.js
        end

    end

    def venue_comment
        @comment = Comment.new
        @comment.user = current_user
        @venue =  Venue.find_by_slug(params[:venue_slug])
        @comment.venue = @venue
        @comment.message = params[:message]
        @comment.save
        respond_to do |format|
                format.js
        end
    end

    def myentries
  		if is_admin_user then
  			@entries = Entry.all.order('updated_at desc').paginate(:page => params[:page], :per_page => per_page).order(:name)
  		else
    		@entries = current_user.entries.order('updated_at desc').paginate(:page => params[:page], :per_page => per_page).order(:name)
    	end
    end

    def myvenues
        if is_admin_user then
            @venues = Venue.all.order('updated_at desc').paginate(:page => params[:page], :per_page => per_page).order(:name)
        else
            @venues = current_user.venues.order('updated_at desc').paginate(:page => params[:page], :per_page => per_page).order(:name)
        end
    end

    def myprograms
        if is_admin_user then
            @programs = Program.all.order('updated_at desc').paginate(:page => params[:page], :per_page => per_page).order(:name)
        else
            @programs = current_user.programs.order('updated_at desc').paginate(:page => params[:page], :per_page => per_page).order(:name)
        end
    end

    def updates
        @entries = Entry.involved_in(current_user)
    end

    def welcome

    end

    def mysettings
        @user = User.find(current_user.id)
    end

end
