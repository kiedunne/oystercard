require 'oystercard'
require 'station'

describe Oystercard do

let(:max_balance) { Oystercard::MAX_BALANCE }
let(:min_fare) { Oystercard::MIN_FARE }
let(:station) { double :station, name: 'Angel', zone: 1 }
let(:journey) { double :journey }

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
    before (:each) do
      subject.top_up(30)
      subject.touch_in(station)
    end

    # it "Can recall trips" do
    #   subject.touch_out(station)
    #   journey = { :entry => station, :exit => station }
    #   expect(subject.history).to eq journey
    # end

    it "Tells journey to record entry station" do
      expect(subject.current_journey).to receive(:enter_station)
      subject.touch_in(station)
    end
  end

  describe ': touch_in: without top up' do
    it "If card balance below minimum fare amount, cannot touch in" do
      expect { subject.touch_in(station) }.to raise_error "Not enough funds to touch in"
    end
  end

  describe ': touch_out' do
    before (:each) do
      subject.top_up(30)
      subject.touch_in(station)
    end

    it "Tells journey to record exit station" do
      expect(subject.current_journey).to receive(:exit_station)
      subject.touch_out(station)
    end

    it "When user touches out- they are deducted the fare for their journey" do
      expect { subject.touch_out(station) }.to change{ subject.balance }.by -min_fare
    end
  end

end
