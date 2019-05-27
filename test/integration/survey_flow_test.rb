require 'test_helper'

class SurveyFlowTest < ActionDispatch::IntegrationTest
  setup do
		@survey = surveys(:one)
		@user_back_office = users(:user_back_office)
		@user_front_office = users(:user_front_office_1)
	end

	test "can see the Surveys page" do
		get "/"
		assert_select "h1", "Enquêtes"
	end

	test "back office user can create an survey" do
		sign_in @user_back_office
		get "/surveys/new"
		assert_response :success

		post "/surveys",
		params: { survey: { title: "can create", abstract: "survey successfully." } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "Title:\n  can create"
	end

	test "back office user can edit an survey" do
		sign_in @user_back_office
		get edit_survey_path(@survey)
		assert_response :success

		post "/surveys",
		params: { survey: { title: "can update", abstract: "survey successfully." } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "Title:\n  can update"
	end

	test "front office user cannot manage an survey" do
		sign_in @user_front_office
		assert_raise(CanCan::AccessDenied) { get "/surveys/new" }
		assert_raise(CanCan::AccessDenied) { get edit_survey_path(@survey) }
	end
end
