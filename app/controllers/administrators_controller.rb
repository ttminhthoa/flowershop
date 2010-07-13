class AdministratorsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout "admin"
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @administrator = Administrator.new
  end
 
  def create
    adminlogout_keeping_session!
    @administrator = Administrator.new(params[:administrator])
    success = @administrator && @administrator.save
    if success && @administrator.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_administrator = @administrator # !! now logged in
      redirect_to :action=>:index,:controller=>:admin
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
end
