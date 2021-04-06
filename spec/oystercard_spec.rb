require 'oystercard'

describe OysterCard do

  describe '#balance' do
    it 'creates new card with 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end
end
