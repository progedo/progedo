# frozen_string_literal: true

Fabricator(:fichier) do
  chemin "fichier test"
  survey { Fabricate.build(:survey) }
end