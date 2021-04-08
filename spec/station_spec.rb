require 'station'

describe Station do
  it "creates a new instance" do
    subject = Station.new("clapham", 2)
    expect(subject).to be_an_instance_of Station
  end

  it "has a name" do
    subject = Station.new("clapham", 2)
    expect(subject.name).to eq("clapham")
  end

  it "has a zone" do
    subject = Station.new("clapham", 2)
    expect(subject.zone).to eq(2)
  end
end 