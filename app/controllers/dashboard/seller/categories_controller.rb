module Dashboard
  module Seller
    class CategoriesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_category, only: [:edit, :update, :destroy]
      layout "seller_layout"

      def index
        Rails.logger.debug "=== CATEGORIES#index called ==="
        if current_user&.seller_profile
          @categories = current_user.seller_profile.categories.order(created_at: :desc)
          Rails.logger.debug "Found #{@categories.size} categories"
        else
          Rails.logger.debug "No seller_profile found for current_user"
          @categories = []
        end
      end

      def new
        Rails.logger.debug "=== CATEGORIES#new called ==="
        if current_user&.seller_profile
          @category = current_user.seller_profile.categories.new
          Rails.logger.debug "Initialized new category: #{@category.inspect}"
        else
          redirect_to dashboard_seller_categories_path, alert: "Seller profile not found."
        end
      end

      def create
        Rails.logger.debug "=== CATEGORIES#create called ==="
        if current_user&.seller_profile
          @category = current_user.seller_profile.categories.new(category_params)
          @category.slug = @category.name.to_s.parameterize
          Rails.logger.debug "Creating category: #{@category.inspect}"

          if @category.save
            Rails.logger.debug "Category created successfully"
            redirect_to dashboard_seller_categories_path, notice: "Category created successfully."
          else
            Rails.logger.debug "Category creation failed: #{@category.errors.full_messages}"
            render :new, status: :unprocessable_entity
          end
        else
          Rails.logger.debug "No seller_profile found while creating category"
          redirect_to dashboard_seller_categories_path, alert: "Seller profile not found."
        end
      end

      def edit
        Rails.logger.debug "=== CATEGORIES#edit called for ID #{params[:id]} ==="
        Rails.logger.debug "Editing category: #{@category.inspect}" if @category
      end

      def update
        Rails.logger.debug "=== CATEGORIES#update called for ID #{params[:id]} ==="
        if @category
          @category.slug = category_params[:name].to_s.parameterize
          if @category.update(category_params)
            Rails.logger.debug "Category updated successfully"
            redirect_to dashboard_seller_categories_path, notice: "Category updated successfully."
          else
            Rails.logger.debug "Category update failed: #{@category.errors.full_messages}"
            render :edit, status: :unprocessable_entity
          end
        end
      end

      def destroy
        Rails.logger.debug "=== CATEGORIES#destroy called for ID #{params[:id]} ==="
        if @category
          @category.destroy
          Rails.logger.debug "Category deleted"
          redirect_to dashboard_seller_categories_path, notice: "Category deleted."
        end
      end

      private

      def set_category
        Rails.logger.debug "=== set_category called with ID #{params[:id]} ==="
        @category = current_user.seller_profile.categories.find_by(id: params[:id])
        if @category.nil?
          Rails.logger.debug "Category not found or does not belong to current seller"
          redirect_to dashboard_seller_categories_path, alert: "Category not found or access denied."
        end
      end

      def category_params
        params.require(:category).permit(:name, :description)
      end
    end
  end
end
