require 'test_helper'

class FichiersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fichier = fichiers(:one)
  end

  test "should get index" do
    get fichiers_url
    assert_response :success
  end

  test "should get new" do
    get new_fichier_url
    assert_response :success
  end

  test "should create fichier" do
    assert_difference('Fichier.count') do
      post fichiers_url, params: { fichier: { chemin: @fichier.chemin } }
    end

    assert_redirected_to fichier_url(Fichier.last)
  end

  test "should show fichier" do
    get fichier_url(@fichier)
    assert_response :success
  end

  test "should get edit" do
    get edit_fichier_url(@fichier)
    assert_response :success
  end

  test "should update fichier" do
    patch fichier_url(@fichier), params: { fichier: { chemin: @fichier.chemin } }
    assert_redirected_to fichier_url(@fichier)
  end

  test "should destroy fichier" do
    assert_difference('Fichier.count', -1) do
      delete fichier_url(@fichier)
    end

    assert_redirected_to fichiers_url
  end
end
