require 'cinema_manager'

describe CinemaManager do
  it 'film_screening' do
    time = Time.new
    film_screening = CinemaManager.create_film_screening('the appartment', 120, 'hall 1', 30, 50, time)

    expect(film_screening).to have_attributes(time: time)

    expect(film_screening.film).to have_attributes(name: 'the appartment', duration: 120)
    expect(film_screening.cinema_hall).to have_attributes(name: 'hall 1', rows: 30, cols: 50)

    expect(film_screening.cinema_hall.film_screenings.last).to be(film_screening);
  end
end
