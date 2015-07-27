require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup info" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { username: "",
                               email: "user@invalid",
                               password: "pass",
                               password_confirmation: "word" }
    end
    assert_template 'users/new'
  end

  test "valid signup info" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username: "ExampleUser",
                                            email:    "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'
  end
end
