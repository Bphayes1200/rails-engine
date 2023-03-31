require "rails_helper"

RSpec.describe "Items API" do 
  before :each do 
    @merchant = create(:merchant, id: 1)
    @merchant2 = create(:merchant, id: 2)
    @items = create_list(:item, 3)
    @item_merchant_2 = create(:item, merchant_id: 2)
  end
  it "will send a list of all items" do 

    get "/api/v1/items"
    
    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(4)

    items[:data].each do |item|
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end
  
  it "will send a specific item" do 

    get "/api/v1/items/#{@item_merchant_2.id}"

    expect(response.status).to eq(200)

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes][:description]).to be_a(String)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it "will create a new item" do 

    item_params = ({ 
    name: "New Item",
    description: "Newly Created Item",
    unit_price: 1.1,
    merchant_id: @merchant2.id
    })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response.status).to eq(201)
    expect(created_item.name).to eq("New Item")
    expect(created_item.description).to eq("Newly Created Item")
    expect(created_item.unit_price).to eq(1.1)
    expect(created_item.merchant_id).to eq(@merchant2.id)
  end

  it "will be able to update an item" do 
    previous_name = @item_merchant_2.name
    item_params = {name: "IPhone"}
    headers = {"CONTENT_TYPE" => "application/json"}
    
    patch "/api/v1/items/#{@item_merchant_2.id}", headers: headers, params: JSON.generate({item: item_params})
    
    item = Item.find(@item_merchant_2.id)

    expect(response.status).to eq(200)
    expect(item.name).to eq("IPhone")
    expect(item.name).to_not eq(previous_name)
  end

  it "will be able to delete an item" do
    expect(Item.all).to include(@item_merchant_2)
    expect(Item.all.count).to eq(4)

    delete "/api/v1/items/#{@item_merchant_2.id}"

    expect(Item.all).not_to include(@item_merchant_2)
    expect(Item.all.count).to eq(3)
  end

  it "sends the merchant data from a specific item ID" do 
    
    get "/api/v1/items/#{@item_merchant_2.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)
  
    expect(response.status).to eq(200)
    expect(merchant[:data][:attributes][:name]).to eq(@merchant2.name)
  end

  it "sends a specific item based on a search param" do 

    get "/api/v1/items/find?name=#{@item_merchant_2.name}"

    item =  JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    # expect(item.name).to eq(@item_merchant_2.name)
  end
end