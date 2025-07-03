module Dashboard
  module Seller
    class CategoriesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_category, only: [:edit, :update, :destroy]
      layout "seller_layout"

      def index
        @categories = current_user.seller_profile.categories.order(created_at: :desc)
      end

      def new
        @category = current_user.seller_profile.categories.new
      end

      def create
        @category = current_user.seller_profile.categories.new(category_params)
        @category.slug = @category.name.parameterize

        if @category.save
          redirect_to dashboard_seller_categories_path, notice: "Category created successfully."
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit; end

      def update
        @category.slug = category_params[:name].parameterize
        if @category.update(category_params)
          redirect_to dashboard_seller_categories_path, notice: "Category updated successfully."
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @category.destroy
        redirect_to dashboard_seller_categories_path, notice: "Category deleted."
      end

      private

      def set_category
        @category = current_user.seller_profile.categories.find_by(id: params[:id])
        redirect_to dashboard_seller_categories_path, alert: "Category not found or access denied." unless @category
      end

      def category_params
        params.require(:category).permit(:name, :description)
      end
    end
  end
end
