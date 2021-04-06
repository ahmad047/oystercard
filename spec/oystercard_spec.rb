require 'oystercard'

describe OysterCard do

  describe '#balance' do
    it 'creates new card with 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up the balance' do
      card = subject
      card.top_up(50)
      expect(card.balance).to eq(50)
    end

    it 'raises an error when max_limit reached' do
      maximum_limit = OysterCard::MAXIMUM_LIMIT
      subject.top_up maximum_limit
      expect { subject.top_up 1 }.to raise_error "Max limit of #{maximum_limit}, cannot top-up"
    end
  end

  # describe '#max_limit?' do

  #   it 'returns false when max_limit not reached' do
  #     expect(subject.max_limit?).to be(false)
  #   end

    # it 'returns true when max_limit reached' do
    #   card = subject
    #   card.top_up(90)
    #   expect(card.max_limit?).to be(true)
    # end
  # end
end
