require_relative './application_service'

class MoneyService < ApplicationService
  def buy_ticket(user_id, film_screening_id, place)
    user = repositories[:user].find(user_id)
    screening = repositories[:film_screening].find(film_screening_id)
    ticket = entities[:film_screening_ticket].new(screening, user, place)
    errors = ticket.validate!
    repositories[:film_screening_ticket].save(ticket) unless errors
    [ticket, errors]
  end
end
