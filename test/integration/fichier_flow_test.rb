require 'test_helper'

class FichierFlowTest < ActionDispatch::IntegrationTest
  setup do
	    @fichier = fichiers(:one)
	    @user_back_office = users(:user_back_office)
	    @user_front_office = users(:user_front_office_1)
	    @survey = surveys(:one)
	end

	test "signed user can see the Fichiers page" do
		sign_in @user_back_office
		get "/fichiers"
		assert_select "h1", "Fichiers"
	end

	test "unsigned user cannot see the Fichiers page" do
		get "/fichiers"
		follow_redirect!
		assert_response :success
		assert_select "h2", "Log in"
	end

	test "back office user can create an fichier" do
		sign_in @user_back_office
		get "/fichiers/new"
		assert_response :success

		post "/fichiers",
		params: { fichier: { chemin: "can create", choix_survey: @survey.id } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "Chemin:\n  can create"
	end

	test "back office user can edit an fichier" do
		sign_in @user_back_office
		get edit_fichier_path(@fichier)
		assert_response :success

		post "/fichiers",
		params: { fichier: { chemin: "can update", choix_survey: @survey.id } }
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_select "p", "Chemin:\n  can update"
	end

	test "front office user cannot manage an fichier" do
		sign_in @user_front_office
		assert_raise(CanCan::AccessDenied) { get "/fichiers/new" }
		assert_raise(CanCan::AccessDenied) { get edit_fichier_path(@fichier) }
	end
end
