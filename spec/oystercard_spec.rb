require 'oystercard'

describe Oystercard do

let(:max_balance) { Oystercard::MAX_BALANCE }
let(:min_fare) { Oystercard::MIN_FARE }
let(:station_angel) { double :station, name: 'Angel', zone: 1 }
let(:station_highgate) { double :station, name: 'Highgate', zone: 3 }
let(:journey_max_fare) { double :journey, fare: 6, complete?: true }
let(:journey_min_fare) { double :journey, fare: 1, complete?: false }
let(:log) { double :journeylog, start: true, finish: true }
let(:card) { described_class.new(log) }



  describe ': initialize' do
    it "Has initial card balance of 0" do
      expect(subject.balance).to eq 0
    end
  end

  describe ': top_up' do
    it 'Can top up card multiple times' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "Cannot top up over maximum balance" do
      subject.top_up(max_balance)
      expect { subject.top_up 1 }.to raise_error "Max balance of #{max_balance} exceeded"
    end
  end

  describe ': touch_in' do
    it "If card balance below minimum fare amount, cannot touch in" do
      expect { subject.touch_in(station_angel) }.to raise_error "Not enough funds to touch in"
    end

    it "Records entry station on journey log after touch-in" do
      card.top_up(10)
      expect(log).to receive(:start).with(station_angel)
      card.touch_in(station_angel)
    end
  end

  describe ': touch_out' do
    before (:each) do
      subject.top_up(10)
    end

    it "Records exit station on journey log after touch-out" do
      card.top_up(10)
      expect(log).to receive(:finish).with(station_angel)
      card.touch_out(station_angel)
    end

    # it "deducts min or max fare from balance when touching out" do
    #   expect{card.touch_out(station_angel)}.to change{card.balance}.by(-journey_max_fare.fare)
    # end

    # it "deducts minumum fare when journey complete from Journey class" do
    #   card.top_up(10)
    #   card.touch_in(station_angel)
    #   expect { card.touch_out(station_highgate) }.to change{ card.balance }.by(-journey_min_fare.fare)
    # end
  end
end
