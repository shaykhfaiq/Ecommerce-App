module Dashboard
  module Seller
    class ProductsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_product, only: [:edit, :update, :destroy]
      layout "seller_layout"

      def index
        @products = current_user.seller_profile.products.includes(:category).order(created_at: :desc)
      end

      def new
        if current_user&.seller_profile
          @product = current_user.seller_profile.products.new
          @categories = current_user.seller_profile.categories
        else
          redirect_to dashboard_seller_products_path, alert: "Seller profile not found."
        end
      end

      def create
        if current_user&.seller_profile
          @product = current_user.seller_profile.products.new(product_params)
          @product.is_active=true

          if @product.save
            redirect_to dashboard_seller_products_path, notice: "Product created successfully."
          else
            @categories = current_user.seller_profile.categories
            render :new, status: :unprocessable_entity
          end
        else
          redirect_to dashboard_seller_products_path, alert: "Seller profile not found."
        end
      end

      def edit
        @categories = current_user.seller_profile.categories
      end

      def update
        if @product.update(product_params)
          redirect_to dashboard_seller_products_path, notice: "Product updated successfully."
        else
          @categories = current_user.seller_profile.categories
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @product.destroy
        redirect_to dashboard_seller_products_path, notice: "Product deleted."
      end

      private

      def set_product
        @product = current_user.seller_profile.products.find_by(id: params[:id])
        redirect_to dashboard_seller_products_path, alert: "Product not found." if @product.nil?
      end

      def product_params
        params.require(:product).permit(
          :title, :description, :price, :stock, :category_id, :is_active, images: []
        )
      end

    end
  end
end
