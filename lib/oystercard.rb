require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :history, :current_journey

MAX_BALANCE = 90
MIN_FARE = 1

  def initialize(journey=Journey.new)
    @balance = 0
    @current_journey = journey
  end

  def top_up(amount)
    fail "Max balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE
    @balance += amount
  end
# private
  def deduct(amount)
    @balance -= amount
  end
# public

  def touch_in(station)
    fail "Not enough funds to touch in" if @balance < MIN_FARE
    @current_journey.enter_station(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @current_journey.exit_station(station)
  end

end
