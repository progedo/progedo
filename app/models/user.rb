class User < ApplicationRecord
  rolify
  has_many :requests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def back_office?
    has_role?(:back_office)
  end

  def front_office?
    has_role?(:front_office)
  end 
end
