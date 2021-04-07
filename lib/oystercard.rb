class OysterCard
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1
  attr_accessor :balance, :MAXIMUM_LIMIT

  def initialize(in_journey = false)
    @balance = 0
    @in_journey = in_journey
  end

  def top_up(amount)
    fail "Max limit of #{MAXIMUM_LIMIT}, cannot top-up" if max_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end 

  def touch_in
    raise 'not enough balance' if minimum_balance?

    @in_journey = true
  end 

  def touch_out
    @in_journey = false
  end 


  private
  def max_limit?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end

  def minimum_balance?
    @balance < MINIMUM_BALANCE
  end
end
