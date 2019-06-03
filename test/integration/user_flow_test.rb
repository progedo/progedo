require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  setup do
	    @user_back_office = users(:user_back_office)
	    @user_front_office_1 = users(:user_front_office_1)
	    @user_front_office_2 = users(:user_front_office_2)
	end

	test "signed back office user can see the Users page" do
		sign_in @user_back_office
		get "/users"
		assert_select "h1", "Utilisateurs"
	end

	test "back office user can create an user" do
		sign_in @user_back_office
		get "/users/new"
		assert_response :success

		post "/users",
		params: { user: { password: "password1234", password_confirmation: "password1234", email: "email_test_1@gmail.com", name: "User_name", first_name: "User_first_name" } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "User was successfully created."
	end

	test "back office user can edit an user" do
		sign_in @user_back_office
		get edit_user_path(@user_front_office_1)
		assert_response :success

		post "/users",
		params: { user: { password: "password1234", password_confirmation: "password1234", email: "email_test_1@gmail.com", name: "User_name_upadate", first_name: "User_first_name_update" } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "User was successfully created."
	end

	test "front office user cannot manage an user" do
		sign_in @user_front_office_1
		assert_raise(CanCan::AccessDenied) { get "/users/new" }
		assert_raise(CanCan::AccessDenied) { get edit_user_path(@user_front_office_2) }
	end
	
end
