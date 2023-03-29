require "rails_helper"

describe "Merchants API" do 
  it "Sends a list of merchants" do 
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body, symbolize_names: true)
 
    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end