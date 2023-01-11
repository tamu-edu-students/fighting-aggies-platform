class LoginController < ApplicationController
    def omniauth
      request_params=request.env['omniauth.auth']
      email=request_params.extra.id_info.email.to_s
      if User.exists?(email: email)
        session[:authenticated]=true
      end
      email=email.gsub(".","%1F")
      redirect_to login_path email
    end

    def authorize
      email = current_user.email
      session[:authenticated] = true
      email=email.gsub(".","%1F")
      redirect_to login_path email
    end

    def login
      email=params[:email].gsub("%1F",".")      
      if User.exists?(email: email) && !session[:authenticated].blank? && session[:authenticated]
        user=User.find_by_email email
        if user.role == "Admin"
          session[:admin]=true
          redirect_to admin_path
        else
          session[:coach]=true
          redirect_to dashboard_path
      end  
      else
        flash[:notice] = "Please login as a valid user."
        redirect_to root_path
      end            
    end
    
    def logout
      session[:authenticated]=false
      session[:coach]=false
      session[:admin]=false
      redirect_to root_path
    end
end
