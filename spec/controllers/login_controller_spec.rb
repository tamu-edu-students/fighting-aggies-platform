require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  context 'when user email exists in User model' do
    let(:user) { User.create({:name => 'Test Admin', :role => 'admin', :email => 'user@gmail.com'})}
    let(:email) { user.email }
    let(:request_params) { { 'omniauth.auth' => { 'extra' => { 'id_info' => { 'email' => email } } } } }


    before do
      allow(request).to receive(:env).and_return(request_params)
      allow(request).to receive(:host)
      get :omniauth, params:{provider: "google_oauth2"}
    end

    it 'redirects to the login path' do
      expect(request).to redirect_to(login_path(email.gsub(".","%1F")))
    end

    it 'sets session[:authenticated] to true' do
      expect(session[:authenticated]).to eq true
    end

  end

  context 'when user email does not exist in User model' do
    let(:email) { 'nonexistent@example.com' }
    let(:request_params) { { 'omniauth.auth' => { 'extra' => { 'id_info' => { 'email' => email } } } } }

    before do
      allow(request).to receive(:env).and_return(request_params)
      allow(request).to receive(:host)
      get :omniauth, params:{provider: "google_oauth2"}
    end

    it 'does not set session[:authenticated]' do
      expect(session[:authenticated]).to be_nil
    end
  end
  describe 'login' do
    let(:user) { User.create({ name: 'Test Admin', role: 'admin', email: 'admin@gmail.com' }) }
  
    context 'when user email exists in User model' do
      before do
        session[:authenticated] = true
        get :login, params: { email: user.email }
      end
  
      it 'sets session[:admin] to true' do
        expect(session[:admin]).to eq(true)
      end
  
      it 'redirects to admin path' do
        expect(response).to redirect_to(admin_path)
      end
    end
  
    context 'when user email does not exist in User model' do
      before do
        get :login, params: { email: 'nonexistent@example.com' }
      end
  
      it 'sets flash notice' do
        expect(flash[:notice]).to eq('Please login as a valid user.')
      end
  
      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  
    context 'when user email exists in User model but session[:authenticated] is not set' do
      before do
        session[:authenticated] = false
        get :login, params: { email: user.email }
      end
  
      it 'sets flash notice' do
        expect(flash[:notice]).to eq('Please login as a valid user.')
      end
  
      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  
    context 'when user email exists in User model but user is not admin' do
      let(:user) { User.create({ name: 'Test Coach', role: 'coach', email: 'coach@gmail.com' }) }
      before do
        session[:authenticated] = true
        get :login, params: { email: user.email }
      end
  
      it 'sets session[:coach] to true' do
        expect(session[:coach]).to eq(true)
      end
  
      it 'redirects to dashboard path' do
        expect(response).to redirect_to(dashboard_path)
      end
    end
  
  end
  describe 'logout' do
    before do
      session[:authenticated] = true
      session[:coach] = true
      session[:admin] = true
      delete :logout
    end
    
    it 'sets session[:authenticated] to false' do
      expect(session[:authenticated]).to eq(false)
    end
    
    it 'sets session[:coach] to false' do
      expect(session[:coach]).to eq(false)
    end
    
    it 'sets session[:admin] to false' do
      expect(session[:admin]).to eq(false)
    end
    
    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end
  end
  
end
