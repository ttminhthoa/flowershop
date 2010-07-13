class PartnerController < ApplicationController
  layout "admin"
   before_filter  :adminlogin_required
  def listpartners
    @listpartners=Partner.find(:all)
  end
  def show
    @idpartner=params[:id]
    @partner=Partner.find(@idpartner)
  end
  def destroy
    @partner = Partner.find(params[:id])
    @picture =@partner.picture
    @partner.destroy 
    redirect_to :action=>:listpartners,:controller=>:partner
  end
  def edit
    @partner=Partner.find(params[:id])
    @picture=@partner.picture
  end
  def update
   @partner = Partner.find(params[:id])
   @picture = @partner.picture
    if @picture.update_attributes(params[:picture]) and @partner.update_attributes(params[:partner])
      redirect_to :action => :listpartners,:controller=>:partner
    else
      redirect_to :action=>:index,:controller=>:admin
    end
  end
  def new
    @partner = Partner.new
    @picture = Picture.new
  end
  def create
    @picture = Picture.new(params[:picture])
    @partner = @picture.build_partner(params[:partner])
    if @picture.save
      redirect_to :action => :listpartners
    else
      redirect_to :action => :listpartners
    end
  end
end
