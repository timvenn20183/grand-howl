class DocumentsController < ApplicationController

  before_filter :authenticate_user , :except => [:create]

  def create
  @document = Document.new(document_params)
  @entry = Entry.find_by_slug(params[:entry_id]) if !params[:entry_id].blank?
  @program = Program.find_by_slug(params[:program_id]) if !params[:program_id].blank?
  @document.entry = @entry if !@entry.blank?
  @document.program = @program if !@program.blank?
  respond_to do |format|
    if @document.save
      format.js { render action: 'index' }
    else
    end
  end
  end

  def destroy
  @document = Document.find(params[:id])
  @entry = @document.entry if !@document.entry.blank?
  @program = @document.program if !@document.program.blank?
  respond_to do |format|
    if @document.destroy
      format.js { render action: 'index' }
    end
  end
  end

  def document_params
     params.require(:document).permit!
  end

end
