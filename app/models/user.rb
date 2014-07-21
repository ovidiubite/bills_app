#require 'role_model'

class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



#	include RoleModel

#	roles_attribute :roles_mask
#	roles :admin, :employee

	  ROLES = %w[admin employee]
  
  def role_symbols
    [role.to_sym]
  end


end
