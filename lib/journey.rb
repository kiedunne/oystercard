
class Journey
  attr_reader :journey, :fare
  MIN_FARE = 1
  MAX_FARE = 6

  def initialize
    @journey = {}
    @fare = MIN_FARE
  end

  def enter_station(station)
    @journey[:enter] = station
  end

  def exit_station(station)
    @journey[:exit] = station
  end

  def in_transit?
    !@journey[:enter].nil? && @journey[:exit].nil?
  end

  def complete?
    !@journey[:enter].nil? && !@journey[:exit].nil?
  end

  def fare
    complete? ? zone_fare : MAX_FARE
  end

  def zone_fare
    (@journey[:enter].zone - @journey[:exit].zone).abs + 1
  end

end
