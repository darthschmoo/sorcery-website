class ApplicationController < ActionController::Base
  include AuthlogicControls
  include AuthlogicAccessMethods
  
  protect_from_forgery
  before_filter :log_request

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
        format.html { redirect_to record, notice: '#{record.class.name} was successfully updated.' }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: record.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def standard_destroy_success_response( record )
    respond_to do |format|
      format.html { render template: "/layouts/destroy", locals: { record: record }, layout: nil }
    end
  end
  
  def standard_destroy_failure_response( record )
    respond_to do |format|
      raise "TODO"
    end
  end
  
  def standard_destroy_response( record )
    if record.destroy
      standard_destroy_success_response( record )
    else
      standard_destroy_failure_response( record )
    end
  end
  
  helper_method :reveal_block
  
  def log_request
    request_params = request.env['action_dispatch.request.parameters'].inspect
    request_uri = request.env['REQUEST_URI']
    user_agent = request.env['HTTP_USER_AGENT']
    formats = request.env['action_dispatch.request.formats'].inspect
    remote_addr = request.env['REMOTE_ADDR']
    
    LogRequest.create( { :request_params => request_params,
                         :request_uri    => request_uri,
                         :user_agent     => user_agent,
                         :formats        => formats,
                         :remote_addr    => remote_addr
                     } )
  end
  
  
end
