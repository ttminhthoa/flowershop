# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  include AuthenticatedSystem
  include AuthenticatedAdmin
  before_filter :init

  protected
  def find_cart
    session[:cart] ||= Cart.new
  end
  def init
    @cart=find_cart
    @idlanguage = session[:idlanguage] || 1
    @language = Language.find(@idlanguage)
    @languages = Language.find(:all)
     @categories = Category.find_all_by_parent_id(0)
    @partners = Partner.find(:all)
    if session[:customer_id]
      @cur_customer = Customer.find(session[:customer_id])
    end
    
    @sort1 = @language.constant_menus.find_by_sort(1).menu_name
    @sort2 = @language.constant_menus.find_by_sort(2).menu_name
    @sort3 = @language.constant_menus.find_by_sort(3).menu_name
    @sort4 = @language.constant_menus.find_by_sort(4).menu_name
    @sort5 = @language.constant_menus.find_by_sort(5).menu_name
    @sort6 = @language.constant_menus.find_by_sort(6).menu_name
    @sort9 = @language.constant_menus.find_by_sort(9).menu_name
    @sort10 = @language.constant_menus.find_by_sort(10).menu_name
    @sort11 = @language.constant_menus.find_by_sort(11).menu_name
    @sort12 = @language.constant_menus.find_by_sort(12).menu_name
    @sort13 = @language.constant_menus.find_by_sort(13).menu_name
    @sort14 = @language.constant_menus.find_by_sort(14).menu_name
    @sort15 = @language.constant_menus.find_by_sort(15).menu_name
    @sort18 = @language.constant_menus.find_by_sort(18).menu_name
    @sort34 = @language.constant_menus.find_by_sort(34).menu_name
    @sort38 = @language.constant_menus.find_by_sort(38).menu_name
    @sort42 = @language.constant_menus.find_by_sort(42).menu_name
    @sort46 = @language.constant_menus.find_by_sort(46).menu_name
    @sort47 = @language.constant_menus.find_by_sort(47).menu_name
    
    @products= Product.find(:all,:limit=>3,:order=>"rand()",:conditions=>["ispromotion=? and status=?",1,1])
    @product_promotions=[]
    for product in @products
      @product_promotions << product.product_descriptions.find_by_language_id(@idlanguage)
    end
  end

end
