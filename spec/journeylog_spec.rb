require 'journeylog'

describe JourneyLog do

let(:station_angel) { double :station_angel, name: 'Angel', zone: 1 }
let(:station_bank) { double :station_bank, name: 'Bank', zone: 1 }
let(:journey) { double :journey }

  it { is_expected.to respond_to(:journey_class)}

  it 'add_journey adds entered station to journey log' do
    subject.start(journey)
    expect(subject.journey_log).to eq journey
  end

end
