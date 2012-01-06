require 'test_helper'
require 'tax_works/product'

module TaxWorks
  describe (described_class = Product) do
    describe :price do
      it "should set the price" do
        price = stub
        _     = stub
        instance = described_class.new(price, _)

        instance.price.must_equal price
      end
    end

    describe :name do
      it "should set the name" do
        _    = stub
        name = stub
        instance = described_class.new(_, name)

        instance.name.must_equal name
      end
    end
  end
end
