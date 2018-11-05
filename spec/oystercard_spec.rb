require 'oystercard'

describe Oystercard do

  it "Has initial card balance of 0" do
    expect(subject.balance).to eq 0
  end
end
