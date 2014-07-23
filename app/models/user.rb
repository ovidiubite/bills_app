class User < ActiveRecord::Base

has_many :bills
  # accepts_nested_attributes_for :bills
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

ROLES = %w[admin employee]
  

end
