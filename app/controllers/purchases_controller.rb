class PurchasesController < ApplicationController
  def index
    @category = Category.find_by(id: params[:category_id])
    @purchases = if @category
                   @category.purchases.where(author: current_user).order('created_at DESC')
                 else
                   Purchase.where(author: current_user).order('created_at DESC')
                 end
    session[:return_to] = request.fullpath
  end

  def new
    @category = Category.find_by(id: params[:category_id])
    @user = @category&.user || current_user
    @purchase = Purchase.new
  end

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

  private

  def purchase_params
    params.require(:purchase).permit(:name, :amount, purchase_categories: [category_id: []]).merge(author: current_user)
  end
end
