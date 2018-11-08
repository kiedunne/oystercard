require 'oystercard'

describe Oystercard do

let(:max_balance) { Oystercard::MAX_BALANCE }
let(:min_fare) { Oystercard::MIN_FARE }
let(:station_angel) { double :station, name: 'Angel', zone: 1 }
let(:station_highgate) { double :station, name: 'Highgate', zone: 3 }
let(:journey_max_fare) { double :journey, fare: 6 }
let(:journey_min_fare) { double :journey, fare: 1 }

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

#   describe ': touch_in' do
#     # before (:each) do
#     #   subject.top_up(30)
#     #   subject.touch_in(station_angel)
#     # end
#   #   it "Tells journey to record entry station" do
#   #     expect(subject.current_journey).to receive(:enter_station)
#   #     subject.touch_in(station_angel)
#   #   end
#   # end
# end

  describe ': touch_in: without top up' do
    it "If card balance below minimum fare amount, cannot touch in" do
      expect { subject.touch_in(station_angel) }.to raise_error "Not enough funds to touch in"
    end
  end

  describe ': touch_out' do
    before (:each) do
      subject.top_up(30)
    end

    it "deducts minumum fare when journey complete from Journey class" do
      subject.touch_in(station_angel)
      expect { subject.touch_out(station_highgate) }.to change{ subject.balance }.by -1
    end

    it "deducts maximum fare when journey incomplete from Journey class" do
      expect { subject.touch_out(station_highgate) }.to change{ subject.balance }.by -6
    end
  end
end
