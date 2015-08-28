class CattypesController < ApplicationController

  def index
    @cattypes = Cattype.all
  end

  def new
    @cattype = Cattype.new
    @category = Category.find_by_slug(params[:cat_id])
  end

  def edit
    @cattype = Cattype.find_by_slug(params[:id])
    @category = @cattype.category
  end

  def create
    @cattype = Cattype.new(cattype_params)
    @category = Category.find_by_slug(params[:cat_id])
    @cattype.category = @category
    respond_to do |format|
      if @cattype.save
        format.js { render action: 'index' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
  	@cattype = Cattype.find_by_slug(params[:id])
    respond_to do |format|
      if @cattype.update(cattype_params)
        @category = @cattype.category
        format.js { render action: 'index' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @cattype = Cattype.find_by_slug(params[:id])
    @category = @cattype.category
    @cattype.destroy
    respond_to do |format|
        format.js { render action: 'index' }
    end
  end

  private

    def cattype_params
      params.require(:cattype).permit(:name, :category_id)
    end

end
