
class Oystercard
attr_reader :balance, :last_trip

MAX_BALANCE = 90
MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = nil
    @last_trip = {}
  end

  def top_up(amount)
    fail "Max balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE
    @balance += amount
  end
private
  def deduct(amount)
    @balance -= amount
  end
public

  def touch_in(station)
    fail "Not enough funds to touch in" if @balance < MIN_FARE
    @last_trip[:entry] = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @last_trip[:exit] = station
  end

  def in_journey?
    number_of_trips = @last_trip.length%2
    number_of_trips.odd?
  end

end
