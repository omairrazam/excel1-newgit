class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  
  
  
  # GET /categories
  def index
    @categories = Category.all
    
  end

  # GET /categories/1
  def show
    add_breadcrumb "Categories", :categories_path
    add_breadcrumb "Graphs", category_path(@category)
  end

  # GET /categories/new
  def new
    add_breadcrumb "Categories", :categories_path
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    add_breadcrumb "Categories", :categories_path
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    #debugger
    if @category.save
      #CategoryWorker.perform_async(@category.id)
      #@category.fetch_sp_csv
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  def update_data
    @category     = Category.find(params[:category_id])

    @category.sp_graphs.delete_all
    status = @category.fetch_sp_csv
    if status == -1
      redirect_to category_path(@category),  :flash => { :alert => "Sheet doesn't exist"}
      return
    elsif status == -2
      redirect_to category_path(@category),  :flash => { :alert => 'Column name(s) not correct'}
      return
    end

    @category.graphs.each do |g|
      g.adts.each do |a|
        a.adt_datums.delete_all
        a.update_data_csv
      end
    end

    redirect_to category_path(@category),  :flash => { :success => 'Category Data was successfully updated.'}
    #GraphWorker.perform_async(params[:graph_id])
  end 

   def api_get_sp_data
    @data   = []
    
    category   = Category.find(params[:category_id])

    data    = category.sp_graphs.order('timestamp_ms asc').pluck(:timestamp_ms, :open, :high, :low, :close)
    
    respond_to do |format|
      format.json  { render :json => data } 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    
    # Only allow a trusted parameter "white list" through.
    def category_params
      
      params.require(:category).permit(:name, 
                                       :open_colname, 
                                       :close_colname,
                                       :high_colname,
                                       :low_colname,
                                       :sp_x_colname,
                                       :sheetname,
                                       :order_num,
                                       graphs_attributes: [:id, 
                                                           :name,
                                                           :x_colname,
                                                           :y1_colname,
                                                           :y2_colname,
                                                           :sheetname,
                                                           :y1_legend,
                                                           :y2_legend, 
                                                           :color_y1,
                                                           :color_y2,
                                                           :_destroy])
    end
   
end
