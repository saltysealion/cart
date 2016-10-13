class AdditionalItemRule < Rule
  attr_accessor :product, :product_code, :required_quantity

  def initialize(product, product_code, required_quantity)
    @product = product
    @product_code = product_code
    @required_quantity = required_quantity
  end

  def apply_on(items, promotional_code = nil)
    discountable_products = items.select{ |product| product_code == product.code }
    if discountable_products.count >= required_quantity
      product.price = 0
      items.push product.clone
    end
    
    items
  end
end
