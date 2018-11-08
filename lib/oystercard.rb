require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :history, :journey_log, :current_journey

MAX_BALANCE = 90
MIN_FARE = 1

  def initialize(journey_log=JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
    @current_journey = Journey.new
  end

  def top_up(amount)
    fail "Max balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Not enough funds to touch in" if @balance < MIN_FARE
    @current_journey.enter_station(station)
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    @current_journey.exit_station(station)
    deduct(@current_journey.fare)
  end

  private
    def deduct(amount)
      @balance -= amount
    end
end
