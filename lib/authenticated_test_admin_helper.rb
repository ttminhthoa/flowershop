class AuthenticatedTestAdminHelper
    def adminlogin_as(administrator)
    @request.session[:administrator_id] = administrator ? (administrator.is_a?(Administrator) ? administrator.id : administrators(administrator).id) : nil
  end

  def adminauthorize_as(administrator)
    @request.env["HTTP_AUTHORIZATION"] = administrator ? ActionController::HttpAuthentication::Basic.encode_credentials(administrators(administrator).login, 'monkey') : nil
  end
end