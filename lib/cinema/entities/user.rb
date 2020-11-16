require 'securerandom'
require_relative './application_entity'
require_relative '../lib/validation'

class User < ApplicationEntity
  include Validation

  EMAIL_FORMAT = URI::MailTo::EMAIL_REGEXP

  attr_reader :id, :email, :created_at

  validate :email, :presence
  validate :email, :format, EMAIL_FORMAT

  def initialize(email)
    @id = SecureRandom.uuid
    @email = email
    @created_at = Time.now
  end
end
