class Request < ApplicationRecord
	resourcify
	has_and_belongs_to_many :fichiers
  belongs_to :user
end
