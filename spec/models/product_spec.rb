require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "should save" do     
      @category = Category.new(name: "Dining Room Furniture")
      @product = Product.new(name: "chair", price_cents: 8000, quantity: 1, :category => @category)
      @product.save
      expect(@product).to be_valid
    end
    
    it "should have a name" do
      @category = Category.new(name: "Living Room Furniture")
      @product = Product.new(name: nil, price_cents: 8000, quantity: 1, :category => @category)   
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors[:name ]).to include("can\'t be blank")
    end

    it "should have a category" do
      @product = Product.new(name: "chair", price_cents: 8000, quantity: 1, :category => nil)
      @product.save      
      expect(@product).to_not be_valid        
      expect(@product.errors[:category]).to include("can\'t be blank")
    end
  
  end
end
