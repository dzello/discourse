require 'rails_helper'
require 'file_helper'

describe FileHelper do

  let(:url) { "https://eviltrout.com/trout.png" }
  let(:png) { Base64.decode64("R0lGODlhAQABALMAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwICAgP8AAAD/AP//AAAA//8A/wD//wBiZCH5BAEAAA8ALAAAAAABAAEAAAQC8EUAOw==") }

  before do
    stub_request(:get, url).to_return(body: png)
  end

  describe "download" do
    it "returns a file with the image" do
      tmpfile = FileHelper.download(url, 10000, 'trouttmp')
      expect(tmpfile.read[0..5]).to eq("GIF89a")
    end

    it "works with a protocol relative url" do
      tmpfile = FileHelper.download("//eviltrout.com/trout.png", 10000, 'trouttmp')
      expect(tmpfile.read[0..5]).to eq("GIF89a")
    end
  end

end