require_relative './application_service'

class MoneyService < ApplicationService
  def create_film_screening(film_id, cinema_hall_id, time)
    film = repositories[:film].find(film_id)
    cinema_hall = repositories[:cinema_hall].find(cinema_hall_id)
    price = repositories[:price].find_by(cinema_hall: cinema_hall)
    cost = price.calculate_for(time) if price

    film_screening = entities[:film_screening].new(film, cinema_hall, time, cost)
    errors = film_screening.validate!
    repositories[:film_screening].save(film_screening) unless errors

    [film_screening, errors]
  end

  def buy_ticket(user_id, film_screening_id, place)
    user = repositories[:user].find(user_id)
    film_screening = repositories[:film_screening].find(film_screening_id)
    ticket = entities[:film_screening_ticket].new(film_screening, user, place)
    errors = ticket.validate!
    return [ticket, errors] if errors

    capital_transaction = entities[:capital_transaction].new(ticket, 'income')
    errors = capital_transaction.validate!

    unless errors
      repositories[:film_screening_ticket].save(ticket)
      repositories[:capital_transaction].save(capital_transaction)
    end

    [ticket, errors]
  end

  def create_price(cinema_hall_id, value)
    cinema_hall = repositories[:cinema_hall].find(cinema_hall_id)
    price = entities[:price].new(value, cinema_hall)
    errors = price.validate!
    repositories[:price].save(price) unless errors

    [price, errors]
  end

  def refund_ticket(ticket_id)
    ticket = repositories[:film_screening_ticket].find(ticket_id)
    return false if ticket.returned?

    capital_transaction = entities[:capital_transaction].new(ticket, 'loss')
    errors = capital_transaction.validate!
    return [ticket, errors] if errors

    repositories[:capital_transaction].save(capital_transaction)
    ticket.refund
    repositories[:film_screening_ticket].save(ticket)

    true
  end
end
