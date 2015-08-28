class CategoriesController < ApplicationController

    layout 'main'


	before_filter :authenticate_admin, :except => [:show, :list]

    def list
        respond_to do |format|
             format.json { render json: Category.visable.map {|model| {:id => model.slug, :name => model.name}}}
        end

    end

	def destroy
		category = Category.find_by_slug(params[:id])
		category.destroy
		redirect_to '/admin/categories'
	end

    def show
        session[:view_style] = params[:view_style] if !params[:view_style].blank?
        set_user_view_style(params[:view_style]) if !params[:view_style].blank?
        @category = Category.find_by_slug(params[:id])
        @entries = @category.entries.filtered(session[:user]).paginate(:page => params[:page], :per_page => per_page)
        respond_to do |format|
            format.html
            format.json { render json: @entries.all.map {|model| {:id => model.slug, :name => model.name}}}
        end
    end

	def edit
		@category = Category.find_by_slug(params[:id])
	end

	def new
		@category = Category.new
	end

	def create
	    @category = Category.new(category_params)
        if @category.save
        	render action: :edit
      	else
        	render action: :new
        end
  	end

	def update
		@category = Category.find_by_slug(params[:id])
        if @category.update(category_params)
      		redirect_to '/admin/categories'
        else
        	render action: 'edit'
        end
	end

	def custom_update
        params[:id] = params[:cat_id]
        @category = Category.find(params[:cat_id])
        @category.options[:advancements] = !@category.options[:advancements] if params[:advancements] == '1'
        @category.options[:has_time] = !@category.options[:has_time] if params[:has_time] == '1'
        @category.options[:has_theme] = !@category.options[:has_theme] if params[:has_theme] == '1'
        @category.options[:has_outcome] = !@category.options[:has_outcome] if params[:has_outcome] == '1'
        @category.options[:has_badge] = !@category.options[:has_badge] if params[:has_badge] == '1'
        @category.options[:has_story] = !@category.options[:has_story] if params[:has_story] == '1'
        @category.options[:has_song] = !@category.options[:has_song] if params[:has_song] == '1'
        @category.options[:has_other] = !@category.options[:has_other] if params[:has_other] == '1'
        @category.options[:has_play] = !@category.options[:has_play] if params[:has_play] == '1'
        @category.options[:has_resources] = !@category.options[:has_resources] if params[:has_resources] == '1'
        @category.options[:has_instructions] = !@category.options[:has_instructions] if params[:has_instructions] == '1'
        @category.save
        render :nothing => true
	end

 	private

    def category_params
      params.require(:category).permit(:name, :cat_id, :image)
    end

end
