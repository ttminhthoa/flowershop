class AdminController < ApplicationController
  before_filter  :adminlogin_required
  def index
end
  def listcustomers
    @listcustomers=Customer.find(:all)
  end
  def show
    @customer = Customer.find(params[:id])
  end
  def edit
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id])
    if  @customer.update_attributes(params[:customer])
      redirect_to :action=>:listcustomers,:controller=>:admin
    end
  end
  def change_password
    
  end
  def change_password_update
    if Administrator.authenticate(current_administrator.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        current_administrator.password_confirmation = params[:password_confirmation]
        current_administrator.password = params[:password]
                
        if current_administrator.save!
          flash[:notice] = "Password successfully updated"
          redirect_to loginadmin_path
        else
          flash[:alert] = "Password not changed"
          render :action => 'change_password'
        end
                 
      else
        flash[:alert] = "New Password mismatch"
        render :action => 'change_password'
      end
    else
      flash[:alert] = "Old password incorrect"
      render :action => 'change_password'
  end
 end
 end
