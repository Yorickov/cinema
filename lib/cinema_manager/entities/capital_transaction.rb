require 'securerandom'
require_relative './application_entity'
require_relative '../lib/validation'

class CapitalTransaction < ApplicationEntity
  include Validation

  attr_reader :id, :ticket, :cost, :created_at

  validate :ticket, :presence
  validate :cost, :presence
  validate :cost, :type, Integer

  def initialize(ticket)
    @id = SecureRandom.uuid
    @ticket = ticket
    @cost = ticket.cost
    @created_at = Time.now
  end
end
