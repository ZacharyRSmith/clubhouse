require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @admin = users(:admin)
    @user = users(:test_user)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_path
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @admin
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @admin, user: { username: @admin.username, email: @admin.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@admin)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@user)
    patch :update, id: @admin, user: { userusername: @admin.username, email: @admin.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @admin
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @admin
    end
    assert_redirected_to root_url
  end
end
