require_relative './application_service'
require_relative '../entities/user'

class UserService < ApplicationService
  def create_user(email)
    user = User.new(email)
    errors = user.validate!
    user_repository.save(user) unless errors
    [user, errors]
  end
end
