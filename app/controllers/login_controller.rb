class LoginController < ApplicationController
    def omniauth
      request_params=request.env['omniauth.auth']
      email=request_params["extra"]["id_info"]["email"].to_s
      if User.exists?(email: email)
        session[:authenticated]=true
      end
      email=email.gsub(".","%1F")
      redirect_to(login_path(email), allow_other_host: true)
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
        if user.role == "admin"
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
    describe 'authorize' do
      let(:user) { User.create({ name: 'Test User', email: 'user@gmail.com' }) }
      before { controller.stub(:current_user).and_return(user) }
      before { controller.stub(:redirect_to) }
    
      context 'when the user is logged in' do
        before { controller.stub(:logged_in?).and_return(true) }
      
        it 'sets session[:authenticated] to true' do
          expect{ get :authorize }.to change{session[:authenticated]}.from(nil).to(true)
        end
      
        it 'redirects to login path with email' do
          get :authorize
          expect(controller).to have_received(:redirect_to).with(login_path(user.email.gsub(".","%1F")))
        end
      end
    
      context 'when the user is not logged in' do
        before { controller.stub(:logged_in?).and_return(false) }
        before { get :authorize }
      
        it 'does not set session[:authenticated]' do
          expect(session[:authenticated]).to be_nil
        end
      
        it 'does not redirect' do
          expect(controller).not_to have_received(:redirect_to)
        end
      end
    end
end
