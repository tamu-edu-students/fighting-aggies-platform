require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
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