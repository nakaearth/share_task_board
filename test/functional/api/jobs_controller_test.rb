require 'test_helper'

class Api::JobsControllerTest < ActionController::TestCase
  test "should get my_list" do
    get :my_list
    assert_response :success
  end

  test "should get save" do
    get :save
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
