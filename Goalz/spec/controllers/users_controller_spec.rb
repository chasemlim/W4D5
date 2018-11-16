require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new user page' do
      get :new, user: {}
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates presence of username and password' do
        post :create, params: {user: {username: 'baduser'}}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
      
      it 'validates that the password is at least 6 characters long' do
        post :create, params: {user: {username: 'baduser', password: 'a' }}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end
    
    context 'with valid params' do
      it 'redirects to the user show page' do
        post :create, params: {user: {username: 'tester', password: 'password'}}
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end
end
