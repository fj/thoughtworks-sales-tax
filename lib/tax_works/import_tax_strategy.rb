require 'tax_works/tax_strategy'

module TaxWorks
  class ImportTaxStrategy
    include TaxStrategy

    class << self
      def applies_to?(item)
        !!(item.name =~ /imported/)
      end

      def tax_for(item)
        item.price * tax_rate
      end

      def tax_rate
        0.05
      end
    end
  end
end
