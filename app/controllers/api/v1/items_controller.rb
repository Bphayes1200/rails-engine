class Api::V1::ItemsController < ApplicationController
  def index
    render json: MerchantItemsSerializer.new(Item.all)
  end
end