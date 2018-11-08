require 'oystercard'

describe Oystercard do

let(:max_balance) { Oystercard::MAX_BALANCE }
let(:min_fare) { Oystercard::MIN_FARE }
let(:station_angel) { double :station, name: 'Angel', zone: 1 }
let(:station_highgate) { double :station, name: 'Highgate', zone: 3 }
let(:journey) { double :journey, fare: 1, complete?: false }
let(:log) { double :journeylog, start: true, finish: true }
let(:card) { described_class.new(log) }

  describe ': initialize' do
    it "Has initial card balance of 0" do
      expect(card.balance).to eq 0
    end
  end

  describe ': top_up' do
    it 'Can top up card multiple times' do
      expect{ card.top_up 1 }.to change{ card.balance }.by 1
    end

    it "Cannot top up over maximum balance" do
      card.top_up(max_balance)
      expect { card.top_up 1 }.to raise_error "Max balance of #{max_balance} exceeded"
    end
  end

  describe ': touch_in' do
    it "If card balance below minimum fare amount, cannot touch in" do
      expect { card.touch_in(station_angel) }.to raise_error "Not enough funds to touch in"
    end

    it "Records entry station on journey log after touch-in" do
      card.top_up(10)
      expect(log).to receive(:start).with(station_angel)
      card.touch_in(station_angel)
    end
  end

  describe ': touch_out' do
    it "Records exit station on journey log after touch-out" do
      card.top_up(10)
      card.touch_in(station_highgate)
      expect(log).to receive(:finish).with(station_angel)
      card.touch_out(station_angel)
    end

    it "Balance charged correct amount" do
      card.top_up(10)
      card.touch_in(station_angel)
      expect{ card.touch_out(station_highgate) }.to change{ card.balance }.by -3
      end
    end
end
