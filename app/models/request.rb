class Request < ApplicationRecord
	has_and_belongs_to_many :fichiers
  belongs_to :user
end
