require 'station'
require 'oystercard'

describe Station do

  describe " initialize" do
    it "Station has a name" do
      expect(subject.name).to eq "Temple"
    end

    it "Station has a zone" do
      expect(subject.zone).to eq 1
    end
  end


end
