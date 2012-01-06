module TaxWorks
  module TaxStrategy
    def self.included(base)
      add_strategy base
    end

    def self.strategies
      @strategies ||= []
    end

    private

    def self.add_strategy(s)
      strategies << s
    end
  end
end
