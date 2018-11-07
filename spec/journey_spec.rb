require 'oystercard'
require 'station'
require 'journey'

describe Journey do

let(:min_fare) { Journey::MIN_FARE }
let(:max_fare) { Journey::MAX_FARE }

let(:station1) { double :station, name: 'Angel', zone: 1 }
let(:station2) { double :station, name: 'Bank', zone: 1 }
let(:station3) { double :station, name: 'Epping', zone: 3 }

  it "Stores entry and exit stations" do
    subject.enter_station(station1)
    subject.exit_station(station2)
    trip = { :enter => station1, :exit => station2 }
    expect(subject.journey).to eq trip
  end

    describe ' in_transit?' do
      it 'User is in transit when they tap in' do
        subject.enter_station(station1)
        expect(subject).to be_in_transit
        end

      it 'User is not in transit when they complete journey' do
        subject.enter_station(station1)
        subject.exit_station(station2)
        expect(subject).to_not be_in_transit
        end

      it 'User is not in transit when they just tap out' do
        subject.exit_station(station2)
        expect(subject).to_not be_in_transit
        end
    end

    describe ' fare' do
      it 'Returns minimum fare when there is an exit and entry station' do
        subject.enter_station(station1)
        subject.exit_station(station2)
        expect(subject.fare).to eq min_fare
      end

      it 'Returns maximum fare when there is only an exit station' do
        subject.exit_station(station2)
        expect(subject.fare).to eq max_fare
      end

      it 'Returns maximum fare when there is only an entry station' do
        subject.exit_station(station1)
        expect(subject.fare).to eq max_fare
      end
    end



end
