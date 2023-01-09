class LoginController < ApplicationController
    def omniauth
      request_params=request.env['omniauth.auth']
      email=request_params.extra.id_info.email.to_s
      email=email.gsub(".","%1F")
      redirect_to login_path email
    end

    def login
      email=params[:email].gsub("%1F",".")
      if Users.exists?(email: email)
        user=Users.find_by_email email
        if user.role == "admin"
          redirect_to admin_path
        else
          redirect_to dashboard_path
      end  
      else
        redirect_to root_path
      end            
    end
end
