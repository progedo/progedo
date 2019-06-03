require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:one)
    @fichier = fichiers(:one)
    @user_back_office = users(:user_back_office)
    @user_front_office = users(:user_front_office_1)
    @user_front_office_2 = users(:user_front_office_2)
  end

  test "unsigned or front office user should not get index" do
    ability = Ability.new(@user_front_office)
    assert ability.cannot?(:show, @user)
  end


  test "back office user should get index" do
    sign_in @user_back_office
    get users_url
    assert_response :success
  end

  test "back office user should get new" do
    sign_in @user_back_office
    get new_user_url
    assert_response :success
  end

  test "back office user should create user" do
    sign_in @user_back_office
    assert_difference('User.count') do
      post users_url, params: { user: { password: "password1234", password_confirmation: "password1234", email: "email_test@gmail.com", name: @user_back_office.name, first_name: @user_back_office.first_name } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "back office user should show user" do
    sign_in @user_back_office
    get user_url(@user)
    assert_response :success
  end

  test "back office user should get edit" do
    sign_in @user_back_office
    get edit_user_url(@user)
    assert_response :success
  end

  test "back office user should update user" do
    sign_in @user_back_office
    patch user_url(@user), params: { user: { password: "password1234", password_confirmation: "password1234", email: "email_test@gmail.com", name: @user_back_office.name, first_name: @user_back_office.first_name } }
    assert_redirected_to user_url(@user)
  end

  test "back office user should destroy user" do
    sign_in @user_back_office
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "front office user should not manage user" do
    ability = Ability.new(@user_front_office)
    assert ability.cannot?(:destroy, @user_front_office_2)
    assert ability.cannot?(:update, @user_front_office_2)
    assert ability.cannot?(:edit, @user_front_office_2)
    assert ability.cannot?(:new, @user_front_office_2)
  end

end
