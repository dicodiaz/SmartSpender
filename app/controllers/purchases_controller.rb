class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[show edit update destroy]

  def index
    @category = Category.find_by(id: params[:category_id])
    @purchases = if @category
                   @category.purchases.where(author: current_user).order('created_at DESC')
                 else
                   Purchase.where(author: current_user).order('created_at DESC')
                 end
    session[:return_to] ||= request.fullpath
  end

  def show; end

  def new
    @category = Category.find_by(id: params[:category_id])
    @user = @category&.user || current_user
    @purchase = Purchase.new
  end

  def edit; end

  def create
    @purchase = Purchase.new(purchase_params.except(:purchase_categories))
    purchase_params[:purchase_categories][:category_id].drop(1).each do |category_id|
      @purchase.categories << Category.find_by(id: category_id)
    end
    if @purchase.save
      redirect_to session.delete(:return_to) || purchases_path, flash: { success: 'Purchase was successfully created.' }
    else
      flash.now[:error] = @purchase.errors.full_messages.to_sentence.prepend('Error(s): ')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @purchase.update(purchase_params)
      redirect_to purchase_url(@purchase), notice: 'Purchase was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase.destroy

    redirect_to purchases_url, notice: 'Purchase was successfully destroyed.'
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:name, :amount, purchase_categories: [category_id: []]).merge(author: current_user)
  end
end
