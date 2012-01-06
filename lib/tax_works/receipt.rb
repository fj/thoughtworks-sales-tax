require 'bigdecimal'

module TaxWorks
  class Receipt
    attr_accessor :line_items

    def initialize(line_items)
      self.line_items = line_items
    end

    def taxes
      self.line_items.map { |li| li.tax }.inject(BigDecimal.new(0), :+).round(2)
    end

    def total_with_taxes
      self.line_items.map { |li| li.price_with_taxes }.inject(BigDecimal.new(0), :+).round(2)
    end
  end
end
