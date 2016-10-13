class ReducedPriceRule < Rule
  attr_accessor :product_code, :required_quantity, :new_price

  def initialize(new_price, product_code, required_quantity)
    @new_price = new_price
    @product_code = product_code
    @required_quantity = required_quantity
  end

  def apply_on(items, promotional_code = nil)
    discount = 0
    discountable_products = items.select{ |product| product_code == product.code }
    if discountable_products.count > required_quantity
      discount = (discountable_products.first.price - new_price) * discountable_products.count 
    end

    discount
  end
end
