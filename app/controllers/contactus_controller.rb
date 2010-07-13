class ContactusController < ApplicationController
  layout "admin"
   before_filter  :adminlogin_required
  def listcontactus
    @contactnews=ContactUs.find(:all,:conditions=>["status=?",0])
    @count=0
    for @c in @contactnews
      @count = @count + 1
    end
    @listcontact=ContactUs.find(:all).paginate :page => params[:page], :per_page => 6, :order => 'id DESC'
  end
  def show
    @contact=ContactUs.find(params[:id])
    @contact.update_attributes(:status=>1)
  end
  def destroy
    @contact=ContactUs.find(params[:id])
    if @contact.destroy
      redirect_to :action =>:listcontactus,:controller=>:contactus
    end
  end
  end
