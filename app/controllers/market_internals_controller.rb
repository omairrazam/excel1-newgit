class MarketInternalsController < ApplicationController
 
  # GET /market_internals
  def index

    if params[:category_id].present?
      @category = Category.find(params[:category_id])
    else
      @category = Category.first
    end

    # to be use in view
    if params[:date].present?
       @date = params[:date]
    else
       @date = @category.try(:eod_datums).last.try(:datee) if @category.present?
    end

    # for view
    @categories = Category.all.order('id ASC')
    
    @market_internals = @category.eod_datums.all.order('order_number asc').where('datee =?', @date)
    
    
  end
end
