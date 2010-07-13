# This controller handles the login/logout function of the site.  
class SessionadminsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout "admin"
  # render new.rhtml
  def new
  end
  def create
    adminlogout_keeping_session!
    administrator = Administrator.authenticate(params[:login], params[:password])
    if administrator
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_administrator = administrator
      new_cookie_flag = (params[:remember_me] == "1")
      adminhandle_remember_cookie! new_cookie_flag
      redirect_to :action=>:index,:controller=>:admin
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    adminlogout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_to :action=>:index,:controller=>:admin
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
