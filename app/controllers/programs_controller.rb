class ProgramsController < ApplicationController

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
        @programs = Program.for_all.paginate(:page => params[:page], :per_page => per_page)
    end

	def new
		@program = Program.new
	end

    def edit
        @program = Program.find_by_slug(params[:id])
        session[:program] = @program.id
        set_user_current_program
    end

    def pdf
       @program = Program.find_by_slug(params[:id])
       @program.views = 0 if @program.views.blank?
       @program.views += 1
       @program.save
    end

    def show
       @program = Program.find_by_slug(params[:id])
       @program.views = 0 if @program.views.blank?
       @program.views += 1
       @program.save
    end

    def create
        @program = Program.new(program_params)
        @program.start_time = Time.now if @program.start_time == nil
        #program_params[:start_time] = Time.strptime(program_params[:start_time],'%m/%d/%Y %I:%M %p')
        #program_params[:end_time] = Time.strptime(program_params[:end_time],'%m/%d/%Y %I:%M %p')
        @program.user = User.find(session[:user])
        if @program.save
            @program.entries = Entry.where(:isdefault => true)
            @program.save
            @program.build_entry_order
            @program.create_day_breaks
          session[:program] = @program.id
          redirect_to '/programs/' + @program.slug.to_s + '/edit'
        else
            render action: 'new'
        end
    end

    def remove_image
        @program = Program.find_by_slug(params[:id])
        @program.remove_image!
        @program.save
    end

    def program_params
       params.require(:program).permit!
    end

    def update
       @program = Program.find_by_slug(params[:id])
       session[:program] = @program.id
       if @program.update(program_params)
          @program.create_day_breaks
          redirect_to '/myprograms'
       else
          render action: 'edit'
       end
    end

    def destroy
        @program = Program.find_by_slug(params[:id])
        if @program.user == current_user or is_admin_user then
          @program.destroy if @program.can_delete
          clear_current_program
        end
        redirect_to '/myprograms'
    end

    def update_assoc
        @program = Program.find_by_slug(params[:program_id])
        @program.entry_ids = params[:tokens].split(",")
        @program.save
        @program.build_entry_order
        respond_to do |format|
            format.js
        end
    end

    # add a single entry via ajax
    def add_entry
        @entry = Entry.find_by_slug(params[:id])
        if @entry != nil and !current_program.entries.include?(@entry)
            @program = current_program
            @program.entries << @entry
            @program.entryorder[@entry.id] = @program.next_entry_order_id
            @entry.add_scouter_entry(@program,nil)
        end
            @program.save
        redirect_to  '/programs/' + current_program.slug.to_s + '/edit'
    end


    def entry_up
        idx = params[:idx]
        current_program.order_entry_up(idx.to_i)
        current_program.save
        @program = current_program
        respond_to do |format|
            format.js
        end
    end

    def entry_down
        idx = params[:idx]
        current_program.order_entry_down(idx.to_i)
        current_program.save
        @program = current_program
        respond_to do |format|
            format.js
        end
    end

    def custom_time
        @program = current_program
        @program.entrytime[params[:entry_id].to_i] = params[:time].to_i
        @program.save
        respond_to do |format|
                format.js
        end
    end

    def update_linksentence
        @entry = Entry.find_by_id(params[:entry_id])
        @program = Program.find_by_slug(current_program.slug)
        # do we have an entry ?
        @ls = Lsentence.where(:program => @program, :entry => @entry).first
        @ls = Lsentence.new if @ls.blank?
        @ls.program = @program
        @ls.entry = @entry
        @ls.comment = params[:comment]
        @ls.save
        render :nothing => true
    end

    def view_link_sentences
        @program = Program.find_by_slug(current_program.slug)
        @program.viewlinked = !@program.viewlinked
        @program.save
        render :nothing => true
    end

    def update_start_date
        @program = Program.find_by_slug(current_program.slug)
        @program.start_time = params[:start_time]
        @program.save
        @program.create_day_breaks
        respond_to do |format|
            format.js
        end
    end

    def update_end_date
        @program = Program.find_by_slug(current_program.slug)
        @program.end_time = params[:end_time]
        @program.save
        @program.create_day_breaks
        respond_to do |format|
            format.js
        end
    end

    def update_scouter_entry
        @eventscouter = Eventscouter.where(:program => current_program, :entry => params[:entry_id]).first
        @eventscouter.scouter_id = params[:scouter_id]
        @eventscouter.save
        render :nothing => true
    end

    def update_daybreak
        effect_day = params[:day].to_i
        effect_time = params[:time]
        effect_date = params[:date]
        @program = Program.find_by_slug(current_program.slug)
        @program.daybreaks[effect_day] = Time.parse(effect_date + " " + effect_time)
        @program.save
        respond_to do |format|
            format.js
        end
    end

    def drop_entry
        @program = Program.find_by_slug(current_program.slug)
        #entry=entry_drag_38&day=drop_day_2
        e = params[:entry].split("_")[2]
        d = params[:day].split("_")[2]
        @entry = Entry.where(:id => e).first
        respond_to do |format|
            format.js
        end
    end

end



