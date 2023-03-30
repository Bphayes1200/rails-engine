class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show 
    render json: ItemSerializer.new(Item.find(params[:id]))
  end


  def create
    error = ErrorMember.new("Item not created", "BAD REQUEST", 400)
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    else 
      render json: ErrorMemberSerializer.new(error)
    end 
  end

  def update 
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item), status: :ok
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end