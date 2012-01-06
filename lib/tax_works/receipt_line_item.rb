require 'bigdecimal'
require 'tax_works/tax_mediator'

module TaxWorks
  class ReceiptLineItem
    attr_accessor :product, :quantity

    def initialize(product, quantity)
      self.product  = product
      self.quantity = quantity
    end

    def name
      self.product.name
    end

    def price
      (quantity * mediator.price_for(product)).round(2)
    end

    def base_tax
      (quantity * mediator.tax_for(product)).round(2)
    end

    def tax
      rounding_coefficient = BigDecimal.new(1 / rounding_to_nearest_factor)
      (rounding_coefficient * base_tax).ceil / rounding_coefficient
    end

    def price_with_taxes
      price + tax
    end

    def rounding_to_nearest_factor
      BigDecimal.new("0.05", 1)
    end

    def mediator
      TaxMediator
    end
  end
end
