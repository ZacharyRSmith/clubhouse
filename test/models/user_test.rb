require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "ExampleUser", email: "user@example.com",
                     password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "   "
    assert_not @user.valid?
  end

  test "username should be unique" do
    dup_user = @user.dup
    dup_user.username = @user.username.upcase

    assert dup_user.valid?
    @user.save
    assert_not dup_user.valid?
  end

  test "username should have length > 2" do
    @user.username = "a" * 2
    assert_not @user.valid?
  end

  test "username should be no longer than 50 chars" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase

    assert dup_user.valid?
    @user.save
    assert_not dup_user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "email should be less than 255chars" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be valid" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end

    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should be of min length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password should not be too long" do
    @user.password = @user.password_confirmation = "a" * 51
    assert_not @user.valid?
  end
end
