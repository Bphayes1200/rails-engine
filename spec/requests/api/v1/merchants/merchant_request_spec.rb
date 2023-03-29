require "rails_helper"

describe "Merchants API" do 
  before :each do 
    @list = create_list(:merchant, 3)
  end 
  it "Sends a list of merchants" do 

    get "/api/v1/merchants"

    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "finds a specific merchant" do 

    get "/api/v1/merchants/#{@list.first.id}"

    expect(response.status).to eq(200)

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant.count).to eq(1)

    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end