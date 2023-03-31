require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices)}
    it { should belong_to :merchant }
  end 

  describe "::class methods" do 
    before :each do 
      @merchant = create(:merchant)
      @item1 = create(:item)
    end
    it "find_item_by_name" do 
      expect(Item.find_item_by_name(@item1.name)).to eq(@item1)
    end
  end
end 
