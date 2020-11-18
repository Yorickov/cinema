require 'cinema_manager'

describe 'User Service' do
  before(:each) do
    @user_service = CinemaManager['services'][:user]
    @email = 'example@hoo.com'
  end

  it 'create user' do
    user, _errors = @user_service.create_user(@email)
    expect(user).to have_attributes(email: @email)
  end

  it 'create user (errors)' do
    _user, errors = @user_service.create_user('')
    expected = {
      email: ['You must input smth.', 'Invalid format']
    }
    expect(errors).to eq(expected)
  end
end
