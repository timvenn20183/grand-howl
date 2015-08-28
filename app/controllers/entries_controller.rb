class EntriesController < ApplicationController

  layout 'main'


  before_filter :authenticate_user, :except => [:show, :print, :search]

  def show
    @entry = Entry.find_by_slug(params[:id])
    @entry.views += 1
    @entry.save
  end

  def new
    @category = Category.find_by_slug(params[:cat_id])
    @return_program = Program.find_by_slug(params[:return_program]) if !params[:return_program].blank?
    @entry = Entry.new
    @entry.category = @category
  end

  def edit
  	@entry = Entry.find_by_slug(params[:id])
    @category = @entry.category
  end

  def create
    @entry = Entry.new(entry_params)
    @return_program = Program.find_by_slug(params[:return_program]) if !params[:return_program].blank?
    @entry.user = User.find(session[:user])
    @entry.category = Category.find_by_slug(params[:cat_id])
      if @entry.save
          # we need to attch this entry to the program
          if !@return_program.blank?
            @return_program.entries << @entry
            @return_program.save
            @return_program.build_entry_order
            redirect_to '/programs/' + @return_program.slug.to_s + '/edit' if !@return_program.blank?
          else
              redirect_to '/entries' if @return_program.blank?
          end
      else
        render action: 'new'
      end
  end

  def update
  	@entry = Entry.find_by_slug(params[:id])
      if @entry.update(entry_params)
          redirect_to '/entries'
      else
        render action: 'edit'
      end
  end

  def destroy
  	@entry = Entry.find_by_slug(params[:id])
    if @entry.user == current_user or is_admin_user then
      @entry.destroy if @entry.can_delete
    end
          redirect_to '/entries'
  end

  def tokensearch
    @entries = Entry.where('searchtext LIKE ?',"%#{params[:q]}%")
    respond_to do |format|
      format.json { render json: @entries.map {|model| {:id => model.id, :name => model.name}}}
    end
  end

  def search
      @search = params[:search]
      if !@search.blank? then
        @list = @search.split(" ")
        @list.each do |l|
            @db_search = "searchtext like '%" + l.to_s + "%'"
            @db_search = @db_search + " or " if @list.index(l) != @list.count-1
        end
        @entries = Entry.where(@db_search.downcase).paginate(:page => params[:page], :per_page => per_page)
      else
        @entries = Entry.all.paginate(:page => params[:page], :per_page => per_page)
      end
  end

  def remove_image
        @entry = Entry.find_by_slug(params[:id])
        @entry.remove_raw!
        @entry.save
  end


  private

    def entry_params
      params.require(:entry).permit(:name, :category_id, :description, :outcome, :instructions, :other, :resources, :story, :song, :play, :user_id, :cattype_id, :badge_id, :advancement_id, :time, :raw, :isdefault)
    end

end
