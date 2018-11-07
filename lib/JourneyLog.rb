
class JourneyLog
  attr_reader :journey_class, :journey_log

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_log = []
  end

  def start(station)
    @journey_log.unshift(@journey_class.new)
    @journey_log[0].enter_station(station)
  end

  def finish(station)
    @journey_log[0].exit_station(station)
  end

  def add(journey)
    @journey_log << journey
end

end 
