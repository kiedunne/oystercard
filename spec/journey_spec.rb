require 'journey'

describe Journey do

let(:min_fare) { Journey::MIN_FARE }
let(:max_fare) { Journey::MAX_FARE }

let(:station_angel) { double :station_angel, name: 'Angel', zone: 1 }
let(:station_bank) { double :station_bank, name: 'Bank', zone: 3 }

  it "Stores entry and exit stations" do
    subject.enter_station(station_angel)
    subject.exit_station(station_bank)
    trip = { :enter => station_angel, :exit => station_bank }
    expect(subject.journey).to eq trip
  end

    describe ' in_transit?' do
      it 'User is in transit when they tap in' do
        subject.enter_station(station_angel)
        expect(subject).to be_in_transit
        end

      it 'User is not in transit when they complete journey' do
        subject.enter_station(station_angel)
        subject.exit_station(station_bank)
        expect(subject).to_not be_in_transit
        end

      it 'User is not in transit when they just tap out' do
        subject.exit_station(station_bank)
        expect(subject).to_not be_in_transit
        end
    end

    describe ' fare' do
      it 'Returns maximum fare when there is only an exit station' do
        subject.exit_station(station_bank)
        expect(subject.fare).to eq max_fare
        end

      it 'Returns maximum fare when there is only an entry station' do
        subject.exit_station(station_angel)
        expect(subject.fare).to eq max_fare
      end
    end

    describe ' zone_fare' do
      it 'correct zone fare' do
        subject.enter_station(station_angel)
        subject.exit_station(station_bank)
        expect(subject.zone_fare).to eq 3
      end
    end
end 
