require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey = surveys(:one)
    @user_back_office = users(:user_back_office)
    @user_front_office = users(:user_front_office_1)
  end

  test "Anyone should get index" do
    get surveys_url
    assert_response :success
  end

  test "back office user should get new" do
  	sign_in @user_back_office
    get new_survey_url
    assert_response :success
  end

  test "back office user should create survey" do
  	sign_in @user_back_office
    assert_difference('Survey.count') do
      post surveys_url, params: { survey: { abstract: @survey.abstract, title: @survey.title } }
  end

    assert_redirected_to survey_url(Survey.last)
  end

  test "Anyone should show survey" do
    get survey_url(@survey)
    assert_response :success
  end

  test "back office user should get edit" do
  	sign_in @user_back_office
    get edit_survey_url(@survey)
    assert_response :success
  end

  test "back office user should update survey" do
  	sign_in @user_back_office
    patch survey_url(@survey), params: { survey: { abstract: @survey.abstract, title: @survey.title } }
    puts "Son id #{@survey.id} Nom du survey = " + @survey.title
    @survey = Survey.friendly.find(@survey.id)
    assert_redirected_to survey_url(@survey)
  end

  test "back office user should destroy survey" do
  	sign_in @user_back_office
    assert_difference('Survey.count', -1) do
      delete survey_url(@survey)
  	end
    assert_redirected_to surveys_url
  end

  test "front office user should not manage survey" do
	  ability = Ability.new(@user_front_office)
	  assert ability.cannot?(:destroy, @survey)
	  assert ability.cannot?(:update, @survey)
	  assert ability.cannot?(:edit, @survey)
	  assert ability.cannot?(:new, @survey)
  end

end
