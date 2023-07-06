class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:purchases).where(user: current_user).order(:id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, flash: { success: 'Category was successfully added.' }
    else
      flash.now[:error] = @category.errors.full_messages.to_sentence.prepend('Error(s): ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon).merge(user: current_user)
  end
end
