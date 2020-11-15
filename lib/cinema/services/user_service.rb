require_relative './application_service'
require_relative '../entities/user'

class UserService < ApplicationService
  def create_user(email)
    user = User.new(email)
    user_repository.save(user)
    user
  end
end
