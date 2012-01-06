require 'test_helper'
require 'tax_works/import_tax_strategy'

module TaxWorks
  describe (described_class = ImportTaxStrategy) do
    describe :applies_to? do
      it "applies this strategy if it's imported" do
        described_class.applies_to?(stub(:name => 'bag of imported apples')).must_equal true
      end

      it "doesn't apply this strategy if it's not imported" do
        described_class.applies_to?(stub(:name => 'bag of apples')).must_equal false
      end
    end

    describe :tax_for do
      it "reports the tax as #{described_class.tax_rate * 100}% of the price" do
        described_class.tax_for(stub(:price => 25.00)).must_equal 1.25
      end
    end
  end
end
