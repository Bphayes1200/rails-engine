require 'rails_helper'

RSpec.describe Merchant, type: :model do 
  describe "relationships" do 
    it { should have_many :items }
    it { should have_many :invoices}
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end
  
  describe "::class methods" do 
    it "find_all_merchants_by_name" do 
      m1 = create(:merchant, name: "Brian")
      m2 = create(:merchant, name: "Brian")
      m3 = create(:merchant, name: "John")

      expect(Merchant.find_all_merchants_by_name(m1.name)).to eq([m1, m2])
    end
  end
end