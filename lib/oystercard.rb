class OysterCard
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1
  MIN_FARE = 1
  attr_accessor :balance, :MAXIMUM_LIMIT, :MIN_FARE, :entry_station

  def initialize(entry_station = nil)
    @balance = 0
    @entry_station = entry_station
  end

  def top_up(amount)
    fail "Max limit of #{MAXIMUM_LIMIT}, cannot top-up" if max_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end 

  def touch_in(station)
    raise 'not enough balance' if minimum_balance?
    @entry_station = station
  end 

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end 

  private
  def max_limit?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end

  def minimum_balance?
    @balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
