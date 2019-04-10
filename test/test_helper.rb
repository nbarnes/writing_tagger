ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all
  config.include Warden::Test::Helpers

  # Add more helper methods to be used by all tests here...

  def login_user
    visit landing_page_path
    click_on 'Login'
    fill_in 'Email', with: users(:tony).email
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

end
