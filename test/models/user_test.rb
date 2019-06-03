require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def test_a_un_fabricant_valide
    assert Fabricate.build(:user).valid?
    assert Fabricate.build(:back_office).valid?
  end

  test "l'email d'un utilisateur est unique" do
    Fabricate(:user, email: "henri@laposte.net")
    assert Fabricate.build(:user, email: "henri@laposte.net").invalid?
  end

  test "l'email d'un utilisateur est unique peu importe la casse" do
    Fabricate(:user, email: "Henri@LaPoStE.nEt")
    assert Fabricate.build(:user, email: "Henri@LaPoStE.nEt").invalid?
  end

  test "mot de passe obligatoire" do
    assert Fabricate.build(:user, password: nil).invalid?
    assert Fabricate.build(:user, password: "a-password").valid?
  end

  test "renvoie le nom complet de l'utilisateur" do
    utilisateur = Fabricate(:user, name: "Astier", first_name: "Alexandre")
    assert_equal "Alexandre ASTIER", utilisateur.nom_complet
  end

  test "renvoie l'email pour le nom complet si pas de prenom ou pas de nom" do
    utilisateur = Fabricate(:user, name: nil, first_name: nil, email: "alexandre@astier.com")
    assert_equal "alexandre@astier.com", utilisateur.nom_complet
  end

end
