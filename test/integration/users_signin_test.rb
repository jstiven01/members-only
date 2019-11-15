# frozen_string_literal: true

require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'Signin with invalid information' do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test 'Signin with valid information' do
    get signin_path
    post signin_path, params: { session: { email: @user.email, password: 'password' } }
    # assert_redirected_to @user
    # follow_redirect!
    # assert_template 'users/show'
    # assert_select "a[href=?]", signin_path, count: 0
    # assert_select "a[href=?]", signout_path
    # assert_select "a[href=?]", user_path(@user)
  end
end
