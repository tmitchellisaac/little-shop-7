require "rails_helper"

RSpec.describe "show page" do
  before (:each) do
    @merchant_1 = Merchant.create!(name: "Walmart")
    @items = create_list(:item, 31, merchant: @merchant_1)
    @customers = create_list(:customer, 13)
    @customers_with_transactions = create_list(:customer_with_transactions, 13)
    @invoices = create_list(:invoice, 43)
  end

  it "displays the merchant name on the dashboard page" do

    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content(@merchant_1.name)
  end

  it "has a link to the merchant items index, and a link to the merchant invoices index" do

    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("Items")
    expect(page).to have_link("Invoices")
  end

  it "shows name of the top 5 customers based on largest number of successful purchases and their total number of orders" do
    item1 = @merchant_1.items.create!(name: "popcan", description: "fun", unit_price: 100)
    item2 = @merchant_1.items.create!(name: "popper", description: "fun", unit_price: 156)
    item3 = @merchant_1.items.create!(name: "zipper", description: "pants", unit_price: 340)
    item4 = @merchant_1.items.create!(name: "zoozah", description: "doot", unit_price: 354)
    item5 = @merchant_1.items.create!(name: "oiko", description: "zeelk", unit_price: 4)
    item6 = @merchant_1.items.create!(name: "onion pillow", description: "kids", unit_price: 1030)
    item7 = @merchant_1.items.create!(name: "stash", description: "costume", unit_price: 1070)
    item8 = @merchant_1.items.create!(name: "bbq pork powder", description: "toothpaste", unit_price: 1200)
    item9 = @merchant_1.items.create!(name: "arrows", description: "survival", unit_price: 600)
    item10 = @merchant_1.items.create!(name: "cream of pickles", description: "body care", unit_price: 2100)
    item11 = @merchant_1.items.create!(name: "elephant", description: "livestock", unit_price: 2345100)
    item12 = @merchant_1.items.create!(name: "car seat cooler", description: "experimental", unit_price: 23100)
    item13 = @merchant_1.items.create!(name: "sorry notes", description: "dating", unit_price: 10430)
    item14 = @merchant_1.items.create!(name: "crimson tie", description: "costume", unit_price: 10)
    item15 = @merchant_1.items.create!(name: "syrup", description: "self help", unit_price: 13040)
    customer1 = Customer.create!(first_name: "John", last_name: "Smith")
    customer2 = Customer.create!(first_name: "Jane", last_name: "Sornes")
    customer3 = Customer.create!(first_name: "Jaques", last_name: "Snipes")
    customer4 = Customer.create!(first_name: "Jay", last_name: "Snape")
    customer5 = Customer.create!(first_name: "Tom", last_name: "Bullocks")
    customer6 = Customer.create!(first_name: "Jimmy", last_name: "Dirt")
    customer7 = Customer.create!(first_name: "Helva", last_name: "Harrock")
    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer2.invoices.create!(status: 2)
    invoice3 = customer3.invoices.create!(status: 2)
    invoice4 = customer4.invoices.create!(status: 2)
    invoice5 = customer5.invoices.create!(status: 2)
    invoice6 = customer6.invoices.create!(status: 2)
    invoice7 = customer7.invoices.create!(status: 2)
    invoice_item1 = invoice1.invoice_items.create!(item_id: item1.id, quantity: 1, unit_price: 100, status: 2)
    invoice_item2 = invoice1.invoice_items.create!(item_id: item2.id, quantity: 1, unit_price: 156, status: 2)
    invoice_item3 = invoice1.invoice_items.create!(item_id: item3.id, quantity: 1, unit_price: 340, status: 2)
    invoice_item4 = invoice1.invoice_items.create!(item_id: item4.id, quantity: 1, unit_price: 354, status: 2)
    invoice_item5 = invoice1.invoice_items.create!(item_id: item5.id, quantity: 1, unit_price: 4, status: 2)
    invoice_item6 = invoice2.invoice_items.create!(item_id: item6.id, quantity: 1, unit_price: 1030, status: 2)
    invoice_item7 = invoice2.invoice_items.create!(item_id: item7.id, quantity: 1, unit_price: 1070, status: 2)
    invoice_item8 = invoice2.invoice_items.create!(item_id: item8.id, quantity: 1, unit_price: 1200, status: 2)
    invoice_item9 = invoice2.invoice_items.create!(item_id: item9.id, quantity: 1, unit_price: 600, status: 2)
    invoice_item10 = invoice3.invoice_items.create!(item_id: item10.id, quantity: 1, unit_price: 2100, status: 2)
    invoice_item11 = invoice3.invoice_items.create!(item_id: item11.id, quantity: 1, unit_price: 2345100, status: 2)
    invoice_item12 = invoice3.invoice_items.create!(item_id: item12.id, quantity: 1, unit_price: 23100, status: 2)
    invoice_item13 = invoice4.invoice_items.create!(item_id: item13.id, quantity: 1, unit_price: 10430, status: 2)
    invoice_item14 = invoice4.invoice_items.create!(item_id: item14.id, quantity: 1, unit_price: 10, status: 2)
    invoice_item15 = invoice5.invoice_items.create!(item_id: item15.id, quantity: 1, unit_price: 13040, status: 2)
    transaction1 = invoice1.transactions.create!(credit_card_number: 1238567890123476, credit_card_expiration_date: "04/26", result: 0)
    transaction2 = invoice2.transactions.create!(credit_card_number: 1238567590123476, credit_card_expiration_date: "04/26", result: 0)
    transaction3 = invoice3.transactions.create!(credit_card_number: 1238634646123476, credit_card_expiration_date: "04/26", result: 0)
    transaction4 = invoice4.transactions.create!(credit_card_number: 1238567876567476, credit_card_expiration_date: "04/26", result: 0)
    transaction5 = invoice5.transactions.create!(credit_card_number: 1238553460128476, credit_card_expiration_date: "04/26", result: 0)

    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content("Top 5 Customers:")
    expect(page).to have_content("#{customer1.first_name} #{customer1.last_name}... Successful Purchases: 5")
    expect(page).to have_content("#{customer2.first_name} #{customer2.last_name}... Successful Purchases: 4")
    expect(page).to have_content("#{customer3.first_name} #{customer3.last_name}... Successful Purchases: 3")
    expect(page).to have_content("#{customer4.first_name} #{customer4.last_name}... Successful Purchases: 2")
    expect(page).to have_content("#{customer5.first_name} #{customer5.last_name}... Successful Purchases: 1")
  end
end
