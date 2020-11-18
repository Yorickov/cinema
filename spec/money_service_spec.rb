require 'cinema_manager'

describe 'MoneyService' do
  before(:each) do
    @cinema_service = CinemaManager['services'][:cinema]
    @user_service = CinemaManager['services'][:user]
    @money_service = CinemaManager['services'][:money]

    @user, _err = @user_service.create_user('example@hoo.com')
    @film, _err = @cinema_service.create_film('the appartment', 120)
    @cinema_hall, _err = @cinema_service.create_cinema_hall('hall 1', 30, 50)
    @price, _err = @money_service.create_price(@cinema_hall.id, 100)
  end

  it 'create Price' do
    price, _err = @money_service.create_price(@cinema_hall.id, 200)
    expected = {
      value: 200, cinema_hall: @cinema_hall
    }
    expect(price).to have_attributes(expected)
  end

  describe 'creates film screening' do
    it 'successfully' do
      time = Time.new
      film_screening, _errors = @money_service.create_film_screening(
        @film.id, @cinema_hall.id, time
      )
      expected = {
        time: time, film: @film, cinema_hall: @cinema_hall
      }
      expect(film_screening)
        .to have_attributes(expected)
    end

    it 'with errors' do
      expect { @money_service.create_film_screening(@film.id, '', Time.new) }
        .to raise_error('Entity not found')

      expect { @money_service.create_film_screening(@film.id, @cinema_hall.id, '') }
        .to raise_error('Wrong time format')
    end
  end

  describe 'buy ticket' do
    let!(:film_screening) { @money_service.create_film_screening(@film.id, @cinema_hall.id, Time.new)[0] }

    it 'successfully' do
      place = 35
      ticket, _errors = @money_service.buy_ticket(@user.id, film_screening.id, place)
      expected = {
        place: place, film_screening: film_screening, user: @user
      }
      expect(ticket).to have_attributes(expected)
    end

    it 'with errors' do
      expect { @money_service.buy_ticket(@film.id, '', 20) }
        .to raise_error('Entity not found')
    end
  end
end
