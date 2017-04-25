require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  context "validations" do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
  end

  context 'associations with dependency' do
    it { is_expected.to have_many(:authentications).dependent(:destroy)}
  end

  feature 'users sign up' do
    scenario 'with valid email and password' do
      sign_up_with 'name', 'valid@example.com', 'password'
      expect(page).to have_content('Update Profile')
    end

    scenario 'with invalid username' do
      sign_up_with '', 'invalid_email', 'password'
      expect(page).to have_content('Sign Up')
    end

    scenario 'with invalid email' do
      sign_up_with 'name', 'invalid_email', 'password'
      expect(page).to have_content('Sign Up')
    end

    scenario 'with blank password' do
      sign_up_with 'name', 'valid@example.com', ''
      expect(page).to have_content('Sign Up')
    end

    def sign_up_with(username, email, password)
      visit new_user_path
      fill_in 'Username', with: username
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      click_button 'Sign Up'
    end
  end
end
