# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get get signup_path
    assert_response :success
  end

  # test "should get create" do
  #  get users_create_url
  #  assert_response :success
  # end
end