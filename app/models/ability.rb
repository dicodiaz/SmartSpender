class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can(:manage, Category, user:)
    can :manage, Purchase, author: user
  end
end
