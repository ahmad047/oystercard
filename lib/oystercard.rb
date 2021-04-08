class OysterCard
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1
  MIN_FARE = 1
  attr_reader :balance, :MAXIMUM_LIMIT, :MIN_FARE, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
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

  def touch_out(station)
    save_journey(@entry_station, station)
    @exit_station = station
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

  def save_journey(enter_station, exit_station)
    @journeys << { enter: enter_station, exit: exit_station }
  end  
end
