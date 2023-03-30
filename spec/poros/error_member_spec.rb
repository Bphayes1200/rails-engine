require "rails_helper"

RSpec.describe ErrorMember do 
  it "can be accept attributes and be created" do 
    error = ErrorMember.new("No Merchant Found with the ID: 333333", "NOT FOUND", 404)

    expect(error.error_message).to eq("No Merchant Found with the ID: 333333")
    expect(error.status).to eq("NOT FOUND")
    expect(error.code).to eq(404)
  end
end