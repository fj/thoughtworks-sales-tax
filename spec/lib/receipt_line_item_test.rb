require 'test_helper'
require 'tax_works/receipt_line_item'

module TaxWorks
  describe (described_class = ReceiptLineItem) do
    describe :initialize do
      it "should set the product" do
        product  = stub
        _        = stub
        instance = described_class.new(product, _)

        instance.product.must_equal product
      end

      it "should set the quantity" do
        quantity  = stub
        _         = stub
        instance = described_class.new(_, quantity)

        instance.quantity.must_equal quantity
      end 
    end

    describe :price do
      let(:product) { stub(:name => 'gallon of gasoline', :price => 3.999) }
      let(:quantity) { 5 }
      subject { described_class.new product, quantity }

      it "should round the total price to two decimal places" do
        subject.mediator.stubs(:price_for).with(product).returns(product.price)

        subject.price.must_equal (quantity * product.price).round(2)
      end
    end

    describe :base_tax do
      let(:product) { stub(:name => 'gallon of gasoline', :price => 3.999) }
      let(:quantity) { 5 }
      subject { described_class.new product, quantity }

      it "should round the total tax to two decimal places" do
        effective_tax = product.price * 0.2345
        subject.mediator.stubs(:tax_for).with(product).returns(effective_tax)

        subject.base_tax.must_equal (quantity * effective_tax).round(2)
      end
    end

    describe :tax do
      it "rounds the tax up to nearest 0.05 when it exceeds a multiple of 0.05" do
        instance = described_class.new(stub, stub)
        instance.stubs(:base_tax).returns(0.44)

        instance.tax.must_equal BigDecimal.new("0.45")
      end

      it "doesn't round up when it is exactly a multiple of 0.05" do
        instance = described_class.new(stub, stub)
        instance.stubs(:base_tax).returns(0.45)

        instance.tax.must_equal BigDecimal.new("0.45")
      end
    end
  end
end
