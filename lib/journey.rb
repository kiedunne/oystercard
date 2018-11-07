require_relative 'station'
require_relative 'oystercard'

class Journey
  attr_reader :in_transit, :journey, :fare
  MIN_FARE = 1
  MAX_FARE = 6

  def initialize
    @in_transit = false
    @journey = {}
    @fare = 0
  end

  def enter_station(station=nil)
    @in_transit = true
    @journey[:enter] = station
  end

  def exit_station(station=nil)
    @in_transit = false
    @journey[:exit] = station
  end

  def in_transit?
    @in_transit
  end

  def fare
    if @journey.length.even?
      MIN_FARE
    else
      MAX_FARE
    end
  end




end


# class Journey
#   attr_reader :entry_station, :exit_station
#
#   PENALTY_FARE = 6
#
#   def initialize(entry_station: nil)
#     @entry_station = entry_station
#     @complete = false
#   end
#
#   def exit(station=nil)
#     @exit_station = station
#     @complete = true
#     self
#   end
