class AdminController < ApplicationController

	layout 'main'
	before_filter :authenticate_admin

	def index
	end

    def venues
        @venues = Venue.all.order(:name)
    end

	def badges
		@badges = Badge.all.order(:name)
	end

	def categories
		@categories = Category.all.order(:name)
	end

	def advancements
		@advancements = Advancement.all.order(:name)
	end

	def entries
		@entries = Entry.order(:name)
	end

    def users
        @users = User.all
    end

    def programs
    	@programs = Program.all
    end

end
