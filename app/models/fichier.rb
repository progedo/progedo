class Fichier < ApplicationRecord
	has_and_belongs_to_many :surveys
end
