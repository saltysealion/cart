class PromotionalCodeRule < Rule
  attr_accessor :code, :discount_percentage

  def initialize(code, discount_percentage)
    @code = code
    @discount_percentage = discount_percentage
  end

  def apply_on(items, promotional_code)
    discount = 0
    if promotional_code == code
      discount = items.map(&:price).inject(0, &:+) * discount_percentage
    end

    discount
  end
end
