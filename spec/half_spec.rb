require 'Half'

describe Half do
  it 'half' do
    expect(Half.new.call(6)).to eq(3)
  end
end
