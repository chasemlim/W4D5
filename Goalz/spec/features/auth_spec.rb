require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background :each do
    visit new_user_path 
  end 
  
  scenario 'has a new user page' do
    expect(page).to have_content('Sign Up')
  end
  
  scenario 'takes a username and password' do
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end
  
  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      fill_in 'Username', with: 'Peter'
      fill_in 'Password', with: 'password'
      click_button 'Create Account'
      expect(page).to have_content('Peter')
      user = User.find_by(username: 'Peter')
      expect(current_path).to eq(user_path(user))
    end 
      
  end
end

feature 'logging in' do
  background :each do
    User.create(username: 'Peter11', password: 'password')
    visit new_session_path 
  end 
  
  scenario 'shows username on the homepage after login' do
    fill_in 'Username', with: 'Peter11'
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    user = User.find_by(username: 'Peter11')
    expect(current_path).to eq(user_path(user))
  end
  
end

feature 'logging out' do
  background :each do
    visit new_session_path
  end
  
  scenario 'begins with a logged out state' do
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

end