require "application_system_test_case"

class FichiersTest < ApplicationSystemTestCase
  setup do
    @fichier = fichiers(:one)
  end

  test "visiting the index" do
    visit fichiers_url
    assert_selector "h1", text: "Fichiers"
  end

  test "creating a Fichier" do
    visit fichiers_url
    click_on "New Fichier"

    fill_in "Chemin", with: @fichier.chemin
    click_on "Create Fichier"

    assert_text "Fichier was successfully created"
    click_on "Back"
  end

  test "updating a Fichier" do
    visit fichiers_url
    click_on "Edit", match: :first

    fill_in "Chemin", with: @fichier.chemin
    click_on "Update Fichier"

    assert_text "Fichier was successfully updated"
    click_on "Back"
  end

  test "destroying a Fichier" do
    visit fichiers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fichier was successfully destroyed"
  end
end
