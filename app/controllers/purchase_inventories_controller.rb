class PurchaseInventoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @product = Product.find(params[:product_id])
    @purchase_inventories = @product.purchase_inventories.all.page(params[:page]).per(10)
  end

  def show
    @purchase_inventory = PurchaseInventory.find(params[:id])
  end

  def edit
    @purchase_inventory = PurchaseInventory.find(params[:id])
  end
end
