require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_back_office = users(:user_back_office)
    @user_front_office_1 = users(:user_front_office_1)
    @user_front_office_2 = users(:user_front_office_2)
    @request_back_office = requests(:resquest_user_back_office)
    @request_front_office_1 = requests(:resquest_user_front_office_1)
    @request_front_office_2 = requests(:resquest_user_front_office_2)
  end

  test "signed user should get index" do
    sign_in @user_back_office
    get requests_url
    assert_response :success
  end

  test "unsigned user should not get index" do
    get requests_url
    assert_response :redirect
  end

  test "signed user should get new" do
    sign_in @user_front_office_2
    get new_request_url
    assert_response :success
  end

  test "signed user should create request" do
    sign_in @user_front_office_2
    assert_difference('Request.count') do
      post requests_url, params: { request: { description: @request_front_office_2.description, title: @request_front_office_2.title } }
    end

    assert_redirected_to request_url(Request.last)
  end

  test "front office user should show his request" do
    sign_in @user_front_office_2
    get request_url(@request_front_office_2)
    assert_response :success
  end

  test "front office user should not show the request of another" do
    ability = Ability.new(@user_front_office_2)
    assert ability.cannot?(:edit, @request_front_office_1)
  end

  test "back office user should show any request" do
    sign_in @user_back_office
    get request_url(@request_front_office_2)
    assert_response :success
  end

  test "front office user should get edit of his request" do
    sign_in @user_front_office_2
    get edit_request_url(@request_front_office_2)
    assert_response :success
  end

  test "front office user should not get edit of another's request" do
    ability = Ability.new(@user_front_office_2)
    assert ability.cannot?(:edit, @request_front_office_1)
  end

  test "front office user should update his request" do
    sign_in @user_front_office_2
    patch request_url(@request_front_office_2), params: { request: { description: @request_front_office_2.description, title: @request_front_office_2.title } }
    assert_redirected_to request_url(@request_front_office_2)
  end

  test "front office user should not update the request of another" do
    ability = Ability.new(@user_front_office_2)
    assert ability.cannot?(:update, @request_front_office_1)
  end

  test "front office user should destroy his request" do
    sign_in @user_front_office_2
    assert_difference('Request.count', -1) do
      delete request_url(@request_front_office_2)
    end

    assert_redirected_to requests_url
  end

  test "front office user should not destroy the request of another" do
    ability = Ability.new(@user_front_office_2)
    assert ability.cannot?(:destroy, @request_front_office_1)
  end

  test "back office user should manage any request" do
    ability = Ability.new(@user_back_office)
    assert ability.can?(:destroy, @request_front_office_2)
    assert ability.can?(:update, @request_front_office_2)
    assert ability.can?(:edit, @request_front_office_2)
    assert ability.can?(:new, @request_front_office_2)

    assert ability.can?(:destroy, @request_back_office)
    assert ability.can?(:update, @request_back_office)
    assert ability.can?(:edit, @request_back_office)
    assert ability.can?(:new, @request_back_office)
  end

end
