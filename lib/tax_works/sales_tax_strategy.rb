require 'tax_works/tax_strategy'
require 'yaml'

module TaxWorks
  class SalesTaxStrategy
    include TaxStrategy

    class << self
      def applies_to?(item)
        !exemptions.any? { |e| item.name =~ /#{e}/ } 
      end

      def tax_for(item)
        item.price * tax_rate
      end

      def tax_rate
        0.10
      end

      def exemptions
        @exemptions ||= YAML.load exemptions_source_file
      end

      def exemptions_source_file
        File.open exemptions_source_location
      end

      def exemptions_source_location
        exemptions_search_locations.select { |f| File.exists? f }.first
      end

      def exemptions_search_locations
        [
          TaxWorks.exemptions_source,
          File.join(File.dirname(__FILE__), 'exemptions.yml')
        ]
      end
    end
  end
end
