# frozen_string_literal: true

Fabricator(:fichier) do
  chemin "fichier test x"
  survey { Fabricate.build(:survey) }
end