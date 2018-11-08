
class Journey
  attr_reader :journey, :fare
  MIN_FARE = 1
  MAX_FARE = 6

  def initialize
    @journey = {}
    @fare = 0
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
    complete? ? MIN_FARE : MAX_FARE
  end

end
