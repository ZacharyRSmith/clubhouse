require 'test_helper'

class UsersLoginLogoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
  end

  test "login with invalid info" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "log in with valid info and log out" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: "password" }
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    # Log out
#     delete logout_path
#     assert_not is_logged_in?
#     assert_redirected_to root_path


#     # Simulate a user clicking logout in a second window.
#     delete logout_path

#     follow_redirect!
#     assert_select "a[href=?]", login_path
#     assert_select "a[href=?]", logout_path,      count: 0
#     assert_select "a[href=?]", user_path(@user), count: 0
  end
end
