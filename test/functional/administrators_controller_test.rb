require File.dirname(__FILE__) + '/../test_helper'
require 'administrators_controller'

# Re-raise errors caught by the controller.
class AdministratorsController; def rescue_action(e) raise e end; end

class AdministratorsControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :administrators

  def test_should_allow_signup
    assert_difference 'Administrator.count' do
      create_administrator
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Administrator.count' do
      create_administrator(:login => nil)
      assert assigns(:administrator).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Administrator.count' do
      create_administrator(:password => nil)
      assert assigns(:administrator).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Administrator.count' do
      create_administrator(:password_confirmation => nil)
      assert assigns(:administrator).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Administrator.count' do
      create_administrator(:email => nil)
      assert assigns(:administrator).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_administrator(options = {})
      post :create, :administrator => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
