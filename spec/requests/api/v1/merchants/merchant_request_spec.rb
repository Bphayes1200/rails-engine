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

  it "will return all of the merchants based on a search param" do 
    merchant4 = create(:merchant, name: @list.first.name)

    get "/api/v1/merchants/find_all?name=#{merchant4.name}"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes][:name]).to eq(merchant4.name)
    end 
  end
end