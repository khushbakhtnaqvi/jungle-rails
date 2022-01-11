require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "should save" do     
      @category = Category.new(name: "Furniture")
      @product = Product.new(name: "chair", price_cents: 8000, quantity: 1, :category => @category)
      @product.save
      expect(@product).to be_valid
    end

  end
end
