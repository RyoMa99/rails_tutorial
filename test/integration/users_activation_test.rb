require 'test_helper'

class UsersActivationTest < ActionDispatch::IntegrationTest
  def setup
    @unactivated_user = users(:papa)
    @activated_user = users(:archer)
    @activated_another_user = users(:malory)
  end
  
  test "unactivated user can't be shown at users page" do
    log_in_as(@activated_user)
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@activated_user)
    assert_select "a[href=?]", user_path(@activated_another_user)
    assert_select "a[href=?]", user_path(@unactivated_user), count: 0
  end
  
  test "unactivated user can't be shown at user show page" do
    log_in_as(@activated_user)
    get user_path(@activated_user)
    assert_template 'users/show'
    get user_path(@unactivated_user)
    assert_redirected_to root_path
  end

end
