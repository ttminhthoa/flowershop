class LanguageController < ApplicationController
  layout "admin"
   before_filter  :adminlogin_required
  def listlanguages
  end

end
