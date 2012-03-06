class ApplicationController < ActionController::Base
  include AuthlogicControls
  include AuthlogicAccessMethods
  
  protect_from_forgery

  def must_be_logged_in
    unless logged_in?
      flash[:error] = "You can't do that."
      redirect_to "/" and return false
    end
  end
  
  def logged_in?( &block )
    if current_author_session
      yield if block_given?
      current_author_session
    else
      false
    end
  end
  
  def abandon_action( msg = "You can't do that.", go = { action: :index } )
    flash[:error] = msg
    redirect_to go
  end
  
  helper_method :logged_in?
  
  def reveal_block( title, &block )
    r = render :partial => "/layouts/reveal_block" do
      yield if block_given?
    end
    
    r.join("\n").html_safe
  end
  
  def standard_response( record )
    respond_to do |format|
      format.html
      format.json { render :json, record }
      format.xml { render :xml, record }
    end
  end
  
  def standard_save_on_create_response( record )
    if record.save
      respond_to do |format|
        format.html { redirect_to record, notice: "#{record.class.name} was successfully created."}
        format.json { render json: record, status: :created, location: record }
      end  
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: record.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def standard_update_record_response record, _params
    if record.update_attributes(_params)
      respond_to do |format|
        format.html { redirect_to record, notice: 'Author was successfully updated.' }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: record.errors, status: :unprocessable_entity }
      end
    end
  end
  
  helper_method :reveal_block
end
