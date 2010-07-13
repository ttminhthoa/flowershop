require File.dirname(__FILE__) + '/../test_helper'
require 'customers_controller'

# Re-raise errors caught by the controller.
class CustomersController; def rescue_action(e) raise e end; end

class CustomersControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :customers

  def test_should_allow_signup
    assert_difference 'Customer.count' do
      create_customer
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Customer.count' do
      create_customer(:login => nil)
      assert assigns(:customer).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Customer.count' do
      create_customer(:password => nil)
      assert assigns(:customer).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Customer.count' do
      create_customer(:password_confirmation => nil)
      assert assigns(:customer).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Customer.count' do
      create_customer(:email => nil)
      assert assigns(:customer).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_customer(options = {})
      post :create, :customer => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
