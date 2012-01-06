require 'test_helper'
require 'tax_works/tax_mediator'

module TaxWorks
  describe (described_class = TaxMediator) do
    describe :applicable_strategies_for do
      it "determines appropriate strategies" do
        strategies = [true, false].map { |val| stub(:applies_to? => val) }
        applicable, _ = strategies.partition { |s| s.applies_to? }

        TaxStrategy.stubs(:strategies).returns(strategies)

        described_class.applicable_strategies_for(stub).must_equal applicable
      end
    end

    describe :tax_for do
      it "calculates the tax from appropriate strategies" do
        strategies = [
          stub(:tax_for => BigDecimal.new(1)),
          stub(:tax_for => BigDecimal.new(2)),
          stub(:tax_for => BigDecimal.new(3))
        ]

        described_class.stubs(:applicable_strategies_for).returns(strategies)

        described_class.tax_for(stub).must_equal strategies.map(&:tax_for).inject(0, :+)
      end
    end

    describe :price_for do
      it "calculates the price from the product" do
        product = stub(:price => BigDecimal.new(100))

        described_class.price_for(product).must_equal BigDecimal.new("100")
      end
    end
  end
end
