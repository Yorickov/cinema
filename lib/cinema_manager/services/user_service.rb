require_relative './application_service'

class UserService < ApplicationService
  def create_user(email)
    user = entities[:user].new(email)
    errors = user.validate!
    repositories[:user].save(user) unless errors
    [user, errors]
  end
end
