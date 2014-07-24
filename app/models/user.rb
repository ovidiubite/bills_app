class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains	
  has_many :bills
  # accepts_nested_attributes_for :bills
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

ROLES = %w[admin employee]
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end

end
