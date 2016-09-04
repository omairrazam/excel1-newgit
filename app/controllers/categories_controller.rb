class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :verify_sheet_exists, only: [:create, :update_data]
  
  
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
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    #debugger
    if @category.save
      #CategoryWorker.perform_async(@category.id)
      @category.fetch_sp_csv
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

    @new_category      = Category.new

    @new_category.id   = @category.id
    @new_category.name = @category.name

    @new_category.open_colname  = @category.open_colname
    @new_category.close_colname = @category.close_colname
    @new_category.high_colname = @category.high_colname
    @new_category.low_colname  = @category.low_colname
    @new_category.sp_x_colname = @category.sp_x_colname
    @new_category.sheetname    = @category.sheetname
    @new_category.order_num    = @category.order_num

    @category.destroy

    if @new_category.save
      @new_category.fetch_sp_csv
    #GraphWorker.perform_async(params[:graph_id])
      redirect_to categories_path,  :flash => { :success => 'Category Data was successfully updated.'}
    end
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

    def verify_sheet_exists
      if File.exist?(Rails.root.to_s +  "/excelsheet/actual.csv") 
      else 
        redirect_to categories_path,  :flash => { :alert => 'No File.'}
      end
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
