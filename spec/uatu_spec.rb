require "spec_helper"

RSpec.describe Uatu do
  describe 'version number' do
    it "has a version number" do
      expect(Uatu::VERSION).not_to be nil
    end
  end
end
