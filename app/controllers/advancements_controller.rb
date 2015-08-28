class AdvancementsController < ApplicationController

    before_filter :authenticate_admin, :except => [:show, :index, :pdf]

    layout :select_layout

    def select_layout
      if action_name == 'pdf'
            return 'print'
        else
            return 'main'
        end
    end

    def pdf
        @advancement = Advancement.find_by_slug(params[:id])
    end

    def show
        @advancement = Advancement.find_by_slug(params[:id])
        respond_to do |format|
            format.html
            format.json {}
        end
    end

    def index
        @advancements = Advancement.all.order(:name)
        respond_to do |format|
            format.html
            format.json { render json: @advancements.all.map {|model| {:id => model.slug, :app_name => model.app_name,:name => model.name}}}
        end
    end


	def destroy
		advancement = Advancement.find_by_slug(params[:id])
		advancement.destroy
		redirect_to '/admin/advancements'
	end

	def edit
		@advancement = Advancement.find_by_slug(params[:id])
	end

	def update
		@advancement = Advancement.find_by_slug(params[:id])
	    if @advancement.update(advancement_params)
	        redirect_to '/admin/advancements'
	    else
	        format.html { render action: 'edit' }
	   	end
	end

	def create
		@advancement = Advancement.new(advancement_params)
		if @advancement.save
			redirect_to '/admin/advancements'
		else
			format.html { render action: 'edit' }
		end
	end

	def new
		@advancement = Advancement.new
	end

    def advancement_params
      params.require(:advancement).permit(:name, :description, :challenge_id, :advlevel_id)
    end



end
