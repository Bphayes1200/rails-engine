class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end


  def create
    # error = ErrorMember.new("Item not created", "BAD REQUEST", 400)
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    else 
      render json: ErrorMemberSerializer.new(error)
    end 
  end

  def update 
    # error = ErrorMember.new("Item not updated", "BAD REQUEST", 400)
    item = Item.find(params[:id])
 
    if params[:merchant_id] != nil
      if Merchant.find(params[:merchant_id])
        item.update(item_params)
        render json: ItemSerializer.new(item), status: :ok
      else 
        error_memember = ErrorMemberSerializer.new(error)
        render json: error_member.serialized_json
      end
    else 
      item.update(item_params)
      render json: ItemSerializer.new(item), status: :ok
    end  
  end

  def destroy
    item = Item.find(params[:id]).destroy
  end

  def find 
    # error = ErrorMember.new("Internal Server Error", "Internal Server Error", 500)
    if Item.find_item_by_name(params[:name]) != (nil) 
      item = Item.find_item_by_name(params[:name])
      render json: ItemSerializer.new(item), status: :ok
    else 
      render json: ErrorMemberSerializer.new(error).serialized_json
    end
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end