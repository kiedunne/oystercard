require 'journeylog'

describe JourneyLog do

let(:station_angel) { double :station_angel, name: 'Angel', zone: 1 }
let(:station_bank) { double :station_bank, name: 'Bank', zone: 1 }
let(:journey) { double :journey }

  it { is_expected.to respond_to(:journey_class)}

  it 'start records the entry station from journey class' do
    subject.start(station_bank)
    expect(subject.journey_log[0].journey[:enter]).to eq station_bank
  end

  it 'finish records the exit station from journey class' do
    subject.start(station_bank)
    subject.finish(station_angel)
    expect(subject.journey_log[0].journey[:exit]).to eq station_angel
  end
end
