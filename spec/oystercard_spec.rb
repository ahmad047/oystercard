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
  end
end
