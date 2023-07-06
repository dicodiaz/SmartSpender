require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'welcome page' do
    before(:each) { visit welcome_path }

    it "displays the app's name" do
      expect(page).to have_content('SmartSpender')
    end

    it "displays a 'LOG IN' link that redirects to the login page" do
      click_link('LOG IN')
      expect(page).to have_current_path(new_user_session_path)
    end

    it "displays a 'SIGN UP' link that redirects to the register page" do
      click_link('SIGN UP')
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end
