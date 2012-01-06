require 'test_helper'
require 'tax_works/tax_strategy'

module TaxWorks
  describe (described_class = TaxStrategy) do
    describe :included do
      it "contains the strategy after including" do
        C = Class.new { include described_class }
        described_class.strategies.must_include C
      end
    end
  end
end
