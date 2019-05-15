class User < ApplicationRecord
  rolify
  has_many :requests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:front_office) if self.roles.blank?
  end

  def back_office?
    has_role?(:back_office)
  end

  def front_office?
    has_role?(:front_office)
  end 
end
