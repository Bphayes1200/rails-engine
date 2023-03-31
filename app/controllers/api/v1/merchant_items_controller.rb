class Api::V1::MerchantItemsController < ApplicationController
  def index
    error = ErrorMember.new("Merchant Not Found", "NOT FOUND", 404)
    merchant = Merchant.find(params[:merchant_id])
    if merchant != nil
      render json: ItemSerializer.new(merchant.items)
    else 
      render json: ErrorMemberSerializer.new(error).serialized_json
    end 
  end
end