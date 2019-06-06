require 'test_helper'

class RequestTest < ActiveSupport::TestCase

  test "a une fabrique valid" do
    assert Fabricate.build(:request).valid?
  end

  test "a un titre" do
    request = Fabricate.build(:request, title: "titre")
    assert_equal "titre", request.title
  end

  test "a une description" do
    request = Fabricate.build(:request, description: "description")
    assert_equal "description", request.description
  end

  test "invalide sans user" do
    assert Fabricate.build(:request, user: nil).invalid?
  end

  test "invalide sans fichier" do
    assert Fabricate.build(:request, fichiers: []).valid?
  end

end
