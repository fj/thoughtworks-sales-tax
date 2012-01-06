require 'test_helper'
require 'tax_works/sales_tax_strategy'

module TaxWorks
  describe (described_class = SalesTaxStrategy) do
    describe :applies_to? do
      before(:each) do
        described_class.stubs(:exemptions).returns(['apple', 'banana'])
      end

      it "doesn't apply this strategy if there's a matching exemption" do
        described_class.applies_to?(stub(:name => 'bag of apples')).must_equal false
      end

      it "applies this strategy if there isn't a matching exemption" do
        described_class.applies_to?(stub(:name => 'bag of peaches')).must_equal true
      end
    end

    describe :exemptions do
      it "loads YAML from the source" do
        described_class.stubs(:exemptions_source_file).returns("- apple\n- banana")

        described_class.exemptions.must_equal ['apple', 'banana']
      end
    end

    describe :exemptions_source_location do
      it "picks the first one that exists" do
        described_class.stubs(:exemptions_search_locations).returns [
          "missing.txt", "present.txt"
        ]

        File.stubs(:exists?).with("missing.txt").returns(false)
        File.stubs(:exists?).with("present.txt").returns(true)

        described_class.exemptions_source_location.must_equal "present.txt"
      end
    end

    describe :tax_for do
      it "reports the tax as #{described_class.tax_rate * 100}% of the price" do
        described_class.tax_for(stub(:price => 25.00)).must_equal 2.50
      end
    end
  end
end
