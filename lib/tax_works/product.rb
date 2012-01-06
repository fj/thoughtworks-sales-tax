module TaxWorks
  class Product
    attr_accessor :price, :name

    def initialize(price, name)
      self.price = price
      self.name  = name
    end
  end
end
