require 'station'

describe Station do
  it "creates a new instance" do
    station = Station.new("clapham", 2)
    expect(station).to be_an_instance_of Station
  end

  it "has a name" do
    station = Station.new("clapham", 2)
    expect(station.name).to eq("clapham")
  end

  it "has a zone" do
    station = Station.new("clapham", 2)
    expect(station.zone).to eq(2)
  end
end 