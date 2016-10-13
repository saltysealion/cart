require 'spec_helper'

describe 'Cart' do
  before :each do
    @cart = Cart.new
    @item1 = Product.new 'ult_small', 'Unlimitef 1 GB', 24.90
    @item2 = Product.new 'ult_medium', 'Unlimitef 2 GB', 29.90
    @item3 = Product.new 'ult_large', 'Unlimitef 5 GB', 44.90
    @item4 = Product.new '1gb', '1 GB Data-pack', 9.90
  end

  describe 'Unlimited 1GB deal' do
    before :each do
      free_item_rule = FreeItemRule.new 'ult_small', 3 
      discount_rules = [free_item_rule]
      @cart = Cart.new discount_rules
      @cart.add @item3
      @cart.add @item1
      @cart.add @item1.clone
      @cart.add @item1.clone
    end

    it 'Provides 1 ult_small for free' do
      expect(@cart.total).to eq(94.70)
    end

    it 'Contain 4 items' do
      expect(@cart.items.count).to eq(4)
    end
  end

  describe 'Unlimited 5GB deal' do
    before :each do
      reduced_price_rule = ReducedPriceRule.new 39.90, 'ult_large', 3
      discount_rules = [reduced_price_rule]
      @cart = Cart.new discount_rules
      @cart.add @item3
      @cart.add @item3.clone
      @cart.add @item3.clone
      @cart.add @item3.clone
      @cart.add @item1
      @cart.add @item1.clone
    end

    it 'Provides 1 ult_small for free' do
      expect(@cart.total).to eq(209.40)
    end

    it 'Contain 6 items' do
      expect(@cart.items.count).to eq(6)
    end
  end

  describe 'Unlimited 2GB deal' do
    before :each do
      additional_item_rule = AdditionalItemRule.new @item4, 'ult_medium', 1
      item_rules = [additional_item_rule]
      @cart = Cart.new [], item_rules
      @cart.add @item1
      @cart.add @item2
      @cart.add @item2.clone
    end

    it 'Provides free data-packs' do
      expect(@cart.total).to eq(84.70)
    end

    it 'Adds one data-pack per 2GB sim' do
      expect(@cart.items.count).to eq(5)
    end
  end

  describe 'Promo code' do
    before :each do
      promotional_code_rule = PromotionalCodeRule.new 'I<3AMAYSIM', 0.1
      discount_rules = [promotional_code_rule]
      @cart = Cart.new discount_rules
      @cart.add @item1
      @cart.add @item4
      @cart.promotional_code = 'I<3AMAYSIM'
    end

    it 'Provides a discount on the total' do
      expect(@cart.total).to eq(31.32)
    end

    it 'Contains 2 items in the cart' do
      expect(@cart.items.count).to eq(2)
    end
  end
end
