require 'oystercard'

describe OysterCard do

  context '#balance' do
    it 'creates new card with 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end

  context '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up the balance' do
      expect { subject.top_up(50) }.to change { subject.balance }.by(50)
    end

    it 'raises an error when max_limit reached' do
      maximum_limit = OysterCard::MAXIMUM_LIMIT
      subject.top_up(maximum_limit)
      expect { subject.top_up 1 }.to raise_error "Max limit of #{maximum_limit}, cannot top-up"
    end
  end

  context "#deduct" do
    it 'deducts the balance' do
      subject.top_up(50)
      expect { subject.deduct(25) }.to change { subject.balance }.by(-25)
    end
  end

  context '#in_journey?' do
    it 'starts off false before touch in' do
      expect(subject.in_journey?).to eq(false)
    end
  end 
  
  context '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it 'changes the value of in_journey to true' do
      allow(subject).to receive(:minimum_balance?).and_return false
      subject.touch_in
      expect(subject.in_journey?).to be true
    end 

    it 'raises an error if balance is less than 1' do
      expect { subject.touch_in }.to raise_error('not enough balance')
    end
  end 

  context '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it 'changes the value of in_journey back to false' do
      allow(subject).to receive(:minimum_balance?).and_return false
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to be false
    end 
  end
end




# redundant tests
  # describe '#max_limit?' do

  #   it 'returns false when max_limit not reached' do
  #     expect(subject.max_limit?).to be(false)
  #   end

    # it 'returns true when max_limit reached' do
    #   card = subject
    #   card.top_up(90)
    #   card.top_up(1)
    #   expect(card.max_limit?).to be(true)
    # end
  # end