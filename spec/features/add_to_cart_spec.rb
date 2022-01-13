require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see an updated value of 1 in My Cart" do
    visit root_path
    # VERIFY
    save_screenshot
    expect(page).to have_text 'My Cart (0)'
    
    #selecting product page
    click_link_or_button('Add', match: :first)
    save_screenshot
    expect(page).to have_text 'My Cart (1)'
  end
end
