require 'oystercard'

describe Oystercard do

  let (:entry_station) { double('entry_station') }
  let (:exit_station) { double('exit_station') }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it { is_expected.to be_an_instance_of Oystercard }

  it "can show a balance" do
    expect(subject).to respond_to(:balance)
  end

  it { expect(subject).to respond_to(:top_up).with(1).argument }

  it "enables you to top up by 5 pounds" do
    subject.top_up(5)
    expect(subject.balance).to eq(5)
  end

  it "does not allow more than £90 to be topped up" do
    subject.top_up(Oystercard::MAX_BALANCE)
    expect { subject.top_up(1) }.to raise_error "max balance #{Oystercard::MAX_BALANCE} reached"
  end

  it "does not allow a intial value over £90 to be topped up" do
    expect { subject.top_up(91) }.to raise_error "top up value can not be over #{Oystercard::MAX_BALANCE}"
  end

  it { is_expected.to respond_to(:touch_in) }

  it "returns a true value when card touches in" do
    subject.top_up(Oystercard::MAX_BALANCE)
    subject.touch_in(entry_station)
    expect(subject).to be_in_journey
  end

  it { is_expected.to respond_to(:touch_out) }

  it "returns a true value when card touches out" do
    subject.top_up(Oystercard::MAX_BALANCE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.in_journey?).to be_falsey
  end

  it "returns a fail message if balance is less than £1" do
    expect { subject.touch_in(entry_station) }.to raise_error "Balance is less than £1"
  end

  it "deducts £1 from the balance once card touches out" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station) }.to change{subject.balance}.by(-Oystercard::MIN_VALUE)
  end

  it "has a nil entry station at the start" do
    expect(subject.entry_station).to be_nil
  end

  it "has an entry station when card touches in" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq(entry_station)
  end

  it "sets entry statiom to nil when card touches out" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.entry_station).to be_nil
  end

  it 'defauts the jouney history to empty' do
    expect(subject.journey_history).to be_empty
  end

  it 'touch out stores the exit station value' do 
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end

  it 'stores the journey in journey history' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    p subject.journey_history
    expect(subject.journey_history).to include(journey)
  end 

end
