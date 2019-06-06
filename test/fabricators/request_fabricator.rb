# frozen_string_literal: true

Fabricator(:request) do
  title "requete test"
  description "description test"
  user Fabricate.build(:user)
  fichiers { [Fabricate.build(:fichier), Fabricate.build(:fichier)] }
end