require 'tax_works/receipt'
require 'tax_works/receipt_line_item'
require 'tax_works/product'

module TaxWorks
  class InputFile
    def self.to_receipt(file)
      Receipt.new file.readlines.map { |line| to_receipt_line_item line }
    end

    def self.receipt_entry_format
      @receipt_entry_format ||= /^(\d+) (.+) at \$?(\d.+)$/
    end

    def self.to_receipt_line_item(line)
      matches, quantity, name, price = receipt_entry_format.match(line).to_a
      
      product  = Product.new(price.to_f, name)
      quantity = quantity.to_i

      ReceiptLineItem.new(product, quantity)
    end
  end
end
