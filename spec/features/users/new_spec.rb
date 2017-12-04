require 'rails_helper'

RSpec.feature 'New User' do

  scenario "invalid signup information" do
   visit signup_path

   within '#new_user' do
     fill_in('user_name', with: 'ra')
     fill_in('user_email', with: 'ra')
     fill_in('user_password', with: 'ra')
     fill_in('user_password_confirmation', with: 'ra')

     click_button('Sign Up')
   end
   expect(find('h1')).to have_content('Sign Up Page')

  end

  scenario "valid signup information" do
   visit signup_path

   within '#new_user' do
     fill_in('user_name', with: 'ra')
     fill_in('user_email', with: 'ragy@gma.com')
     fill_in('user_password', with: 'r123456')
     fill_in('user_password_confirmation', with: 'r123456')

     click_button('Sign Up')
   end
   expect(find('h1')).to have_content('home')

  end

end
