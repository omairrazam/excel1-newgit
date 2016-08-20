class InteractiveChartsController < ApplicationController
	require 'roo'
	before_action :get_all_categories

	def show_page
		
		@selected_category = Category.first
	
		if @selected_category.present?
			@graphs 		   = @selected_category.graphs 
			@sp_graph_data     = @selected_category.sp_graphs.pluck(:timestamp_ms, :open, :high, :low, :close)
		else
			flash.now[:notice] = "No Categories found"
		end
		
	end

	def show_by_category
		#debugger
		if params[:category_id]
			@selected_category = Category.find(params[:category_id])
		else
			@selected_category = Category.first
		end

		if @selected_category.present?
			@graphs 		   =  @selected_category.graphs 
			@sp_graph_data     =  @selected_category.sp_graphs.order('timestamp_ms asc').pluck(:timestamp_ms, :open, :high, :low, :close)	
		end

		render "show_page"
	end


	private
	def get_all_categories
		@categories = Category.all
	end
end


