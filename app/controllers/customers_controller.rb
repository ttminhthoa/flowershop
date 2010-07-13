class CustomersController < ApplicationController
   layout "flower"
   before_filter :init2
  # render new.rhtml
  def new

    @customer = Customer.new
  end
 
  def create
    
    logout_keeping_session!

    @customer = Customer.new(params[:customer])
   
    #success = @customer && @customer.save
    #if success && @customer.errors.empty?
    if @customer.save
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_customer = @customer # !! now logged in
      #redirect_back_or_default('/')
      flash[:success] = "Thanks for signing up!<br/>  We're sending you an email with your activation code."
      redirect_to :action=>:new,:controller =>:customers
      
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.<br/>  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  private
  def init2
    @sort19 = @language.constant_menus.find_by_sort(19).menu_name
    @sort20 = @language.constant_menus.find_by_sort(20).menu_name
    @sort21 = @language.constant_menus.find_by_sort(21).menu_name
    @sort24 = @language.constant_menus.find_by_sort(24).menu_name
    @sort22 = @language.constant_menus.find_by_sort(22).menu_name
    @sort25 = @language.constant_menus.find_by_sort(25).menu_name
    @sort27 = @language.constant_menus.find_by_sort(27).menu_name
  end
end
