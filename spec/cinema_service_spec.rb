require 'cinema_manager'

describe 'CinemaService' do
  before(:each) do
    @service = CinemaManager['services'][:cinema]
  end

  it 'creates film' do
    film, _errors = @service.create_film('the appartment', 120)
    expect(film).to have_attributes(name: 'the appartment', duration: 120)
  end

  it 'creates film (errors)' do
    _film, errors = @service.create_film('', '')
    expected = {
      name: ['You must input smth.'],
      duration: ['You must input smth.', 'Wrong type']
    }
    expect(errors).to eq(expected)
  end

  it 'create cinema hall' do
    cinema_hall, _errors = @service.create_cinema_hall('hall 1', 30, 50)
    expect(cinema_hall).to have_attributes(name: 'hall 1', rows: 30, cols: 50)
  end

  it 'creates cinema hall (errors)' do
    _cinema_hall, errors = @service.create_cinema_hall('', 'sc', 50)
    expected = {
      name: ['You must input smth.'],
      rows: ['Wrong type']
    }
    expect(errors).to eq(expected)
  end

  describe 'creates film screening' do
    let!(:film) { @service.create_film('the appartment', 120) }
    let!(:cinema_hall) { @service.create_cinema_hall('hall 1', 30, 50) }

    it 'successfully' do
      time = Time.new
      film_screening, _errors = @service.create_film_screening(film[0].id, cinema_hall[0].id, time)

      expect(film_screening).to have_attributes(time: time)
      expect(film_screening.film).to have_attributes(name: 'the appartment', duration: 120)
      expect(film_screening.cinema_hall).to have_attributes(name: 'hall 1', rows: 30, cols: 50)
    end

    it 'with errors' do
      _film_screening, errors = @service.create_film_screening(film[0].id, cinema_hall[0].id, '')
      expected = {
        time: ['You must input smth.']
      }
      expect(errors).to eq(expected)
    end
  end
end
