module TaxWorks
  class Printer
    attr_accessor :receipt

    def initialize(receipt)
      self.receipt = receipt
    end

    def receipt_lines
      [
        *receipt_line_item_lines,
        sales_tax_line,
        total_line
      ]
    end

    def receipt_line_item_lines
      receipt.line_items.map { |i| line_from_receipt_line_item i }
    end

    def line_from_receipt_line_item(receipt_line_item)
      "#{receipt_line_item.quantity} #{receipt_line_item.product.name}: #{receipt_formatted receipt_line_item.price_with_taxes}"
    end

    def sales_tax_line
      "Sales Taxes: #{receipt_formatted receipt.taxes}"
    end

    def total_line
      "Total: #{receipt_formatted receipt.total_with_taxes}"
    end

    def receipt_formatted(number)
      "%.2f" % number.to_f.round(2)
    end

    def to_s
      receipt_lines
    end

    def print
      puts to_s
    end
  end
end
