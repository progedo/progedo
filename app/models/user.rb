class User < ApplicationRecord
  has_many :requests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  def assign_default_role
    self.back_office = false if self.back_office.blank?
  end

  def nom_complet
    nom_complet = [first_name, name].join(" ").strip
    nom_complet.present? ? nom_complet : email
  end

end
