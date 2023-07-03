class PurchaseCategoriesController < ApplicationController
  before_action :set_purchase_category, only: %i[show edit update destroy]

  def index
    @purchase_categories = PurchaseCategory.all
  end

  def show; end

  def new
    @purchase_category = PurchaseCategory.new
  end

  def edit; end

  def create
    @purchase_category = PurchaseCategory.new(purchase_category_params)

    if @purchase_category.save
      redirect_to purchase_category_url(@purchase_category), notice: 'Purchase category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @purchase_category.update(purchase_category_params)
      redirect_to purchase_category_url(@purchase_category), notice: 'Purchase category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase_category.destroy

    redirect_to purchase_categories_url, notice: 'Purchase category was successfully destroyed.'
  end

  private

  def set_purchase_category
    @purchase_category = PurchaseCategory.find(params[:id])
  end

  def purchase_category_params
    params.require(:purchase_category).permit(:purchase_id, :category_id)
  end
end
