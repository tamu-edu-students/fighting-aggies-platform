class LoginController < ApplicationController
    def omniauth
      request_params=request.env['omniauth.auth']
      email=request_params.extra.id_info.email.to_s
      if Users.exists?(email: email)
        login email
      else
        redirect_to root_path
      end
    end

    private
    def login email       
      user=Users.find_by_email email
      if user.role == "admin"
        redirect_to admin_path
      else
        redirect_to dashboard_path
      end        
    end
end
