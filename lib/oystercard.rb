class OysterCard
  MAXIMUM_LIMIT = 90

  attr_accessor :balance, :MAXIMUM_LIMIT

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Max limit of #{MAXIMUM_LIMIT}, cannot top-up" if max_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private
  def max_limit?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end
end
