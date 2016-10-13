class Cart
  attr_accessor :discount_rules, :item_rules, :items, :promotional_code

  def initialize(discount_rules = [], item_rules = [])
     @discount_rules = discount_rules
     @item_rules = item_rules
     @items = []
  end

  def add(item)
    @items.push item
    item_rules.map { |rule| @items = rule.apply_on(@items) }
  end

  def total
    discount = discount_rules.map { |rule| rule.apply_on(@items, promotional_code) }.inject 0, &:+
    total = @items.map(&:price).inject 0, &:+
    
    (total - discount).round 2
  end
end
