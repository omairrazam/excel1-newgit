class InteractiveChartsController < ApplicationController
	require 'roo'
	before_action :get_all_categories
	skip_authorize_resource only: :show_by_category 
  	skip_authorization_check


	def show_page
		
		@selected_category = Category.first
	
		if @selected_category.present?
			@graphs 		   = @selected_category.graphs .order('order_num asc')
			@sp_graph_data     = @selected_category.sp_graphs.pluck(:timestamp_ms, :open, :high, :low, :close)
		else
			flash.now[:notice] = "No Categories found"
		end
		
	end

	def show_by_category
		
		# if params[:category_id]
		# 	@selected_category = Category.find(params[:category_id])
		# else
		# 	@selected_category = Category.first
		# end

		# if @selected_category.present?
		# 	@graphs 		   =  @selected_category.graphs.order('order_num asc')
		# 	@sp_graph_data     =  @selected_category.sp_graphs.order('timestamp_ms asc').pluck(:timestamp_ms, :open, :high, :low, :close)	
		# end
		@graphs = Graph.all
		render "show_page"
	end


	private
	def get_all_categories
		@categories = Category.all.order('order_num asc')
	end
end


