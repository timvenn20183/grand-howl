class BadgesController < ApplicationController

	layout :select_layout

 	def select_layout
        if action_name == 'pdf'
            return 'print'
        else
            return 'main'
        end
  	end

	before_filter :authenticate_admin, :except => [:pdf, :index, :show]

	def index
		@badges = Badge.all
        respond_to do |format|
            format.html
            format.json { render json: @badges.all.map {|model| {:id => model.slug, :name => model.name}}}
        end
	end

	def destroy
		badge = Badge.find_by_slug(params[:id])
		badge.destroy
		redirect_to '/admin/badges'
	end

	def edit
		@badge = Badge.find_by_slug(params[:id])
	end

	def update
		@badge = Badge.find_by_slug(params[:id])
	    if @badge.update(badge_params)
	        redirect_to '/admin/badges'
	    else
	        format.html { render action: 'edit' }
	   	end
	end

	def create
		@badge = Badge.new(badge_params)
		if @badge.save
			redirect_to '/admin/badges'
		else
			format.html { render action: 'edit' }
		end
	end

	def new
		@badge = Badge.new
	end

    def badge_params
      params.require(:badge).permit(:name, :image, :requirements)
    end

    def pdf
    	@badge = Badge.find_by_slug(params[:id])
    end

    def show
    	@badge = Badge.find_by_slug(params[:id])
        respond_to do |format|
            format.html
            format.json
        end
    end

end
