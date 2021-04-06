class OysterCard
  MAXIMUM_LIMIT = 90

  attr_reader :balance, :MAXIMUM_LIMIT

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Max limit of #{MAXIMUM_LIMIT}, cannot top-up" if amount + balance > MAXIMUM_LIMIT
    @balance += amount
  end

  # def max_limit?
  #   @balance > MAXIMUM_LIMIT
  # end
end
