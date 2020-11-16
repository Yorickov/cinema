require 'cinema/services/cinema_service'
require 'cinema/services/money_service'
require 'cinema/services/user_service'
require 'cinema/repositories/cinema_hall_repository'
require 'cinema/repositories/film_repository'
require 'cinema/repositories/film_screening_repository'
require 'cinema/repositories/film_screening/ticket_repository'
require 'cinema/repositories/user_repository'

describe 'MoneyService' do
  before(:each) do
    repo_types = {
      cinema_hall_repository: CinemaHallRepository,
      film_repository: FilmRepository,
      film_screening_repository: FilmScreeningRepository,
      user_repository: UserRepository,
      ticket_repository: TicketRepository
    }
    repository_instances = repo_types.each_with_object({}) do |(key, value), acc|
      acc[key] = value.new
    end

    @cinema_service = CinemaService.new(repository_instances)
    @user_service = UserService.new(repository_instances)
    @money_service = MoneyService.new(repository_instances)
  end

  it 'create user' do
    email = 'example@hoo.com'
    user, _errors = @user_service.create_user(email)
    expect(user).to have_attributes(email: email)
  end

  it 'create user (errors)' do
    _user, errors = @user_service.create_user('')
    expected = {
      email: ['You must input smth.', 'Invalid format']
    }
    expect(errors).to eq(expected)
  end

  describe 'buy ticket' do
    let(:film) { @cinema_service.create_film('the appartment', 120) }
    let(:cinema_hall) { @cinema_service.create_cinema_hall('hall 1', 30, 50) }
    let(:film_screening) { @cinema_service.create_film_screening(film[0].id, cinema_hall[0].id, Time.new) }
    let(:user) { @user_service.create_user('example@hoo.com') }

    it 'successfully' do
      place = 35
      ticket, _errors = @money_service.buy_ticket(user[0].id, film_screening[0].id, place)
      expect(ticket).to have_attributes(place: place)
      expect(ticket.film_screening).to have_attributes(time: film_screening[0].time)
      expect(ticket.user).to have_attributes(email: user[0].email)
    end

    it 'with errors' do
      _ticket, errors = @money_service.buy_ticket(user[0].id, film_screening[0].id, '')
      expected = {
        place: ['You must input smth.']
      }
      expect(errors).to eq(expected)
    end
  end
end
