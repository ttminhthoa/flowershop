module AuthenticatedAdmin
  
  protected
    # Returns true or false if the administrator is logged in.
    # Preloads @current_administrator with the administrator model if they're logged in.
    def adminlogged_in?
      !!current_administrator
    end

    def current_administrator
      @current_administrator ||= (adminlogin_from_session || adminlogin_from_basic_auth || adminlogin_from_cookie) unless @current_administrator == false
    end

  
    def current_administrator=(new_administrator)
      session[:administrator_id] = new_administrator ? new_administrator.id : nil
      @current_administrator = new_administrator || false
    end

   
    def adminauthorized?(action = action_name, resource = nil)
      adminlogged_in?
    end


    def adminlogin_required
      adminauthorized? || adminaccess_denied
    end

    def adminaccess_denied
      respond_to do |format|
        format.html do
          adminstore_location
          redirect_to new_sessionadmin_path
        end
      
        format.any(:json, :xml) do
          request_http_basic_authentication 'Web Password'
        end
      end
    end

    def adminstore_location
      session[:return_to] = request.request_uri
    end

    def self.included(base)
      base.send :helper_method, :current_administrator, :adminlogged_in?, :authorized? if base.respond_to? :helper_method
    end

    # Called from #current_administrator.  First attempt to login by the administrator id stored in the session.
    def adminlogin_from_session
      self.current_administrator = Administrator.find_by_id(session[:administrator_id]) if session[:administrator_id]
    end

    # Called from #current_administrator.  Now, attempt to login by basic authentication information.
    def adminlogin_from_basic_auth
      authenticate_with_http_basic do |login, password|
        self.current_administrator = Administrator.authenticate(login, password)
      end
    end
    
    def adminlogin_from_cookie
      administrator = cookies[:auth_token] && Administrator.find_by_remember_token(cookies[:auth_token])
      if administrator && administrator.remember_token?
        self.current_administrator = administrator
        adminhandle_remember_cookie! false # freshen cookie token (keeping date)
        self.current_administrator
      end
    end

   
    def adminlogout_keeping_session!
      # Kill server-side auth cookie
      @current_administrator.forget_me if @current_administrator.is_a? Administrator
      @current_administrator = false     # not logged in, and don't do it for me
      adminkill_remember_cookie!     # Kill client-side auth cookie
      session[:administrator_id] = nil   # keeps the session but kill our variable
      # explicitly kill any other session variables you set
    end
   
    def adminlogout_killing_session!
      adminlogout_keeping_session!
      reset_session
    end
    
    def adminvalid_remember_cookie?
      return nil unless @current_administrator
      (@current_administrator.remember_token?) && 
        (cookies[:auth_token] == @current_administrator.remember_token)
    end
    
    # Refresh the cookie auth token if it exists, create it otherwise
    def adminhandle_remember_cookie!(new_cookie_flag)
      return unless @current_administrator
      case
      when valid_remember_cookie? then @current_administrator.refresh_token # keeping same expiry date
      when new_cookie_flag        then @current_administrator.remember_me 
      else                             @current_administrator.forget_me
      end
      adminsend_remember_cookie!
    end
  
    def adminkill_remember_cookie!
      cookies.delete :auth_token
    end
    
    def adminsend_remember_cookie!
      cookies[:auth_token] = {
        :value   => @current_administrator.remember_token,
        :expires => @current_administrator.remember_token_expires_at }
    end
end