require 'securerandom'
require_relative './application_entity.rb'

class User < ApplicationEntity
  attr_reader :id, :email, :created_at

  def initialize(email)
    @id = SecureRandom.uuid
    @email = email
    @created_at = Time.now
  end
end
