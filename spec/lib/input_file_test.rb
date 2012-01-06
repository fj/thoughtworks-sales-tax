require 'test_helper'
require 'tax_works/input_file'

module TaxWorks
  describe (described_class = InputFile) do
    describe :to_receipt_line_item do
      it "should match item descriptions and yield a new receipt line item" do
        line = "1234 pied pipers piping at $10.00"

        described_class.to_receipt_line_item(line).tap do |rli|
          rli.product.price.must_equal 10.00.to_f
          rli.product.name.must_equal "pied pipers piping"
          rli.quantity.must_equal 1234
        end
      end
    end
  end
end
