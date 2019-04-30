class Fichier < ApplicationRecord
	has_and_belongs_to_many :requests
	belongs_to :survey
end
