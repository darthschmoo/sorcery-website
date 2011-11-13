class SimpleLoginController < ApplicationController
  def login
    if params[:passkey] == Sorcery.config.login.passkey
      flash[:notice] = "I submit to your will."
      session[:logged_in] = true
    else
      flash[:error] = "I don't recognize you."
    end
    redirect_to "/"
  end
  
  def logout
    flash[:notice] = "Management appreciates your patronage."
    session[:logged_in] = nil
    redirect_to "/"
  end
end