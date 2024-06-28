class SubcategoriesController < ApplicationController
  def index
    @subcategories = Category.where(parent_id: params[:category_id])
    render json: @subcategories
  end
end
