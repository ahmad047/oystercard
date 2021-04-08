require 'oystercard'

describe OysterCard do
  let(:maximum_limit)    { OysterCard::MAXIMUM_LIMIT }
  let(:minimum_fare)     { OysterCard::MIN_FARE }
  let(:entry_station)    { double :station }
  let(:exit_station)     { double :station }
  let(:journey)          { {enter: entry_station, exit: exit_station} }

  describe '#balance' do
    it 'creates new card with 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up the balance' do
      expect { subject.top_up(50) }.to change { subject.balance }.by(50)
    end

    it 'raises an error when max_limit reached' do
      subject.top_up(maximum_limit)
      expect { subject.top_up 1 }.to raise_error "Max limit of #{maximum_limit}, cannot top-up"
    end
  end

  describe '#in_journey?' do
    it 'starts off as false' do
      expect(subject).not_to be_in_journey
    end
  end 
  
  describe '#touch_in' do
    before { subject.top_up(maximum_limit) }
    
    it 'changes the value of in_journey to true' do
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to be true
    end 

    it 'stores the value of entry_station' do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end 

  context 'raises an error if balance is less than 1' do
    it { expect { subject.touch_in(entry_station) }.to raise_error('not enough balance') } 
  end

  describe '#touch_out' do
    before do
      subject.top_up(maximum_limit)
      subject.touch_in(entry_station)
    end  

    it 'changes the value of in_journey back to false' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to be false
    end 

    it 'deducts the minimum charge from the card' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-minimum_fare)
    end
    
    it 'touch out stores the exit station value' do 
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end

    it 'stores the journey in journey history' do
      subject.touch_out(exit_station)
      expect(subject.journeys).to include(journey)
    end
  end

  it 'defaults the jouney history to empty' do
    expect(subject.journeys).to be_empty
  end

end
