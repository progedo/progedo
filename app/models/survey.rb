class Survey < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_one :fichier
end
