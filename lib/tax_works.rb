module TaxWorks
  require 'bigdecimal'
  Dir.glob(File.join(File.dirname(__FILE__), 'tax_works/**/*.rb')).each do |f|
    require f
  end

  class << self
    def exemptions_source
      File.join(File.dirname(__FILE__), '..', 'exemptions.yml')
    end

    def load_from(file)
      receipt = InputFile.to_receipt(file)
      Printer.new(receipt).tap { |p| p.print }
    end
  end
end
