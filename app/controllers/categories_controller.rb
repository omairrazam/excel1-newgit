class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_category_category_id, only: [:update_data, :update_eod] 
  
  
  # GET /categories
  def index
    @categories = Category.all.order('id asc')
    
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
    #debugger
    job_id = CategoryWorker.perform_async(params[:category_id])

    data = Sidekiq::Status::get_all job_id
    data # => {status: 'complete', update_time: 1360006573, vino: 'veritas'}
    Sidekiq::Status::get     job_id, :vino #=> 'veritas'
    Sidekiq::Status::at      job_id #=> 5
    Sidekiq::Status::total   job_id #=> 100
    Sidekiq::Status::message job_id #=> "Almost done"
    Sidekiq::Status::pct_complete job_id #=> 5

    
    redirect_to category_path(@category), notice: 'Category is updating in background'
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

    def set_category_category_id
      @category = Category.find(params[:category_id])
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
