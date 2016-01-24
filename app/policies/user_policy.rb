class UserPolicy < ApplicationPolicy
  attr_reader :user, :requested_user

  def initialize(user, requested_user)
    @user           = user
    @requested_user = requested_user
  end

  def show?
    current_user_self?
  end

  def update?
    current_user_self?
  end

  private

  def current_user_self?
    requested_user == user
  end
end
