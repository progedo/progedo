require 'test_helper'

class FichierTest < ActiveSupport::TestCase

  test "a une fabrique valid" do
    assert Fabricate.build(:fichier).valid?
  end

  test "a un chemin" do
    fichier = Fabricate.build(:fichier, chemin: "chemin")
    assert_equal "chemin", fichier.chemin
  end

=begin
  test "invalide sans survey" do
    assert Fabricate.build(:fichier, survey_id: nil).invalid?
  end
=end

  test "supprime le fichier quand le survey correspondant est supprimé" do
    survey = Fabricate(:survey)
    fichier = Fabricate(:fichier, chemin: "fichier test a", survey: survey)
    assert_difference('Fichier.count', -1) do
      survey.destroy
    end
  end


end
