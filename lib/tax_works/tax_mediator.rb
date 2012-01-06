require 'tax_works/tax_strategy'

module TaxWorks
  class TaxMediator
    class << self
      def applicable_strategies_for(product)
        [].tap do |applicable_strategies|
          TaxStrategy.strategies.each do |s|
            applicable_strategies << s if s.applies_to? product
          end
        end
      end

      def price_for(product)
        BigDecimal.new(product.price.to_s)
      end

      def tax_for(product)
        applicable_strategies_for(product).
          map { |s| s.tax_for product }.
          inject(BigDecimal.new(0), :+)
      end
    end
  end
end
