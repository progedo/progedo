require 'test_helper'

class FichiersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fichier = fichiers(:one)
    @user_back_office = users(:user_back_office)
    @user_front_office = users(:user_front_office_1)
    @survey = surveys(:one)
  end

  test "signed user should get index" do
    sign_in @user_back_office
    get fichiers_url
    assert_response :success
  end

  test "unsigned user should not get index" do
    get fichiers_url
    assert_response :redirect
  end

  test "back office user should get new" do
    sign_in @user_back_office
    get new_fichier_url
    assert_response :success
  end

  test "back office user should create fichier" do
    sign_in @user_back_office
    assert_difference('Fichier.count') do
      post fichiers_url, params: { fichier: { chemin: @fichier.chemin, choix_survey: @survey.id } }
    end

    assert_redirected_to fichier_url(Fichier.last)
  end

  test "signed user should show fichier" do
    sign_in @user_back_office
    get fichier_url(@fichier)
    assert_response :success
  end

  test "back office user should get edit" do
    sign_in @user_back_office
    get edit_fichier_url(@fichier)
    assert_response :success
  end

  test "back office user should update fichier" do
    sign_in @user_back_office
    patch fichier_url(@fichier), params: { fichier: { chemin: @fichier.chemin } }
    assert_redirected_to fichier_url(@fichier)
  end

  test "back office user should destroy fichier" do
    sign_in @user_back_office
    assert_difference('Fichier.count', -1) do
      delete fichier_url(@fichier)
    end

    assert_redirected_to fichiers_url
  end

  test "front office user should not manage fichier" do
    ability = Ability.new(@user_front_office)
    assert ability.cannot?(:destroy, @fichier)
    assert ability.cannot?(:update, @fichier)
    assert ability.cannot?(:edit, @fichier)
    assert ability.cannot?(:new, @fichier)
  end
end
