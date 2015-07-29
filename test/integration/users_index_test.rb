require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @user = users(:test_user)
  end


  test "users index should work for admin" do
    log_in_as(@admin)

    get users_path
    assert_template 'users/index'

    first_page_of_users = User.all
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.username
      assert_select 'a[href=?]', user_path(user), text: 'delete' unless user == @admin
    end
  end

#   test "users index should paginate" do
    
#   end

#   test "non-admin cannot destroy users" do

#   end

#   test "admin attribute cannot be changed via web" do

#   end

#   test "admin can destroy users" do
#     get users_index_path
#     assert success


#     users.each do |user|
#       assert link user.destroy unless user == admin # admin cannot destroy self
#     end

#     # ensure destroy works
#     assert_difference 'User.count' -1 do

#   end
end
