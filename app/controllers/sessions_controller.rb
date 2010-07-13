# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
   layout "flower"
  # render new.rhtml
  def new
    @sort33 = @language.constant_menus.find_by_sort(33).menu_name
    @sort19 = @language.constant_menus.find_by_sort(19).menu_name
    @sort20 = @language.constant_menus.find_by_sort(20).menu_name
  end

  def create
    logout_keeping_session!
    customer = Customer.authenticate(params[:login], params[:password])
    if customer
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_customer = customer
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      #redirect_back_or_default("/flower/index")
      redirect_to :action=>:index,:controller=>:flower
      flash.now[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      #render :action => 'new'
      redirect_to login_path
    end
  end

  def destroy
    logout_keeping_session!
    flash.now[:notice] = "You have been logged out."
    redirect_to :action=>:index,:controller=>:flower
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end

  
end
