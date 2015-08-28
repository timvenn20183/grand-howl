class VenuesController < ApplicationController


    layout :select_layout

    def select_layout
        if action_name == 'pdf'
            return 'print'
        else
            return 'main'
        end
    end

    before_filter :authenticate_user, :except => [:pdf, :index, :show]


    def index
        @venues = Venue.all.paginate(:page => params[:page], :per_page => per_page)
    end

    def show
       @venue = Venue.find_by_slug(params[:id])
       @venue.views = 0 if @venue.views.blank?
       @venue.views += 1
       @venue.save
    end


    def new
        @venue = Venue.new
    end


    def edit
        @venue = Venue.find_by_slug(params[:id])
    end


    def pdf
       @venue = Venue.find_by_slug(params[:id])
       @venue.views = 0 if @venue.views.blank?
       @venue.views += 1
       @venue.save
    end

    def remove_image
        @venue = Venue.find_by_slug(params[:id])
        @venue.remove_image!
        @venue.save
    end

    def update
       @venue = Venue.find_by_slug(params[:id])
      if @venue.update(venue_params)
          redirect_to '/myvenues'
      else
        render action: 'edit'
      end
    end

    def create
        @venue = Venue.new(venue_params)
        @venue.user = User.find(session[:user])
        if @venue.save
          redirect_to '/myvenues'
        else
            render action: 'new'
        end
    end

    def venue_params

       params.require(:venue).permit!
    end

    def destroy
        @venue = Venue.find_by_slug(params[:id])
        if @venue.user == current_user or is_admin_user then
          @venue.destroy if @venue.can_delete
        end
        redirect_to '/myvenues'
    end

end
