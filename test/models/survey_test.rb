require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "a une fabrique valid" do
    assert Fabricate.build(:survey).valid?
  end

  test "a un titre" do
    survey = Fabricate.build(:survey, title: "titre")
    assert_equal "titre", survey.title
  end

  test "a un abstract" do
    survey = Fabricate.build(:survey, abstract: "abstract")
    assert_equal "abstract", survey.abstract
  end
end
