require "rails_helper"

describe "Merchant Items API" do 
  before :each do 
    @merchant = create(:merchant, id: 1)
    @items = create_list(:item, 3 )
  end 

  it "sends a list of all items for a specific merchant" do 

    get "/api/v1/merchants/#{@merchant.id}/items"

    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end 
  end 
end 