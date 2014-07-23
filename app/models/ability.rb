class Ability
  include CanCan::Ability

  def initialize(user)
       user ||= User.new # guest user
    
    if user.role == "admin"
      can :manage, :all
        elsif user.role == "employee"
            can :manage, Bill
            can :manage, LineItem
          else 
            can :read, :all
       end
     end
end