require 'test_helper'

class RequestFlowTest < ActionDispatch::IntegrationTest
  setup do
		@user_back_office = users(:user_back_office)
		@user_front_office_1 = users(:user_front_office_1)
		@user_front_office_2 = users(:user_front_office_2)
		@request_back_office = requests(:resquest_user_back_office)
		@request_front_office_1 = requests(:resquest_user_front_office_1)
		@request_front_office_2 = requests(:resquest_user_front_office_2)
	end

	test "signed user can see the Requests page" do
		sign_in @user_back_office
		get "/requests"
		assert_select "h1", "Requêtes"
	end

	test "unsigned user cannot see the Requests page" do
		get "/requests"
		follow_redirect!
		assert_response :success
		assert_select "h2", "Log in"
	end

	test "signed user can create an request" do
		sign_in @user_front_office_1
		get "/requests/new"
		assert_response :success

		post "/requests",
		params: { request: { title: "can create", description: "request successfully." } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "Title:\n  can create"
	end

	test "back office user can edit any request" do
		sign_in @user_back_office
		get edit_request_path(@request_front_office_1)
		assert_response :success

		post "/requests",
		params: { request: { title: "can update", description: "request successfully." } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "Title:\n  can update"
	end

	test "front office user can edit his request" do
		sign_in @user_front_office_1
		get edit_request_path(@request_front_office_1)
		assert_response :success

		post "/requests",
		params: { request: { title: "can update", description: "request successfully." } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "Title:\n  can update"
	end

	test "front office user cannot edit the request of another user" do
		sign_in @user_front_office_1
		assert_raise(CanCan::AccessDenied) { get edit_request_path(@request_front_office_2) }
	end
end
