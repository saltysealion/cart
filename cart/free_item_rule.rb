class FreeItemRule < Rule
  attr_accessor :product_code, :required_quantity

  def initialize(product_code, required_quantity)
    @product_code = product_code
    @required_quantity = required_quantity
  end

  def apply_on(items, promotional_code = nil)
    discount = 0
    discountable_products = items.select{ |product| product_code == product.code }
    discount = discountable_products.first.price if discountable_products.count >= required_quantity
    discount
  end
end
