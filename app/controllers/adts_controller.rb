class AdtsController < ApplicationController
	before_action :set_adt, only: [:show, :edit, :update, :destroy]
  after_action :set_breadcrumb, only: [:new, :edit]

  add_breadcrumb "Categories", :categories_path
  skip_authorize_resource only: :api_get_adt_data
  # GET /graphs
  def index
    #@graphs = Graph.all
  end

  # GET /graphs/1
  def show
  end

  # GET /graphs/new
  def new

  	@category =  Category.find(params[:category_id])
    @graph    =  @category.graphs.find(params[:graph_id])
    @adt      =  @graph.adts.new
    add_breadcrumb "Graphs", category_path(@category)
    add_breadcrumb "Data Series", category_graph_path(@category, @graph)
  end

  # GET /graphs/1/edit
  def edit
    add_breadcrumb "Graphs", category_path(@category)
    add_breadcrumb "Data Series", category_graph_path(@category, @graph)
  end

  # POST /graphs
  def create
  	@category =  Category.find(params[:category_id])
    @graph    =  @category.graphs.find(params[:graph_id])
    @adt      =  @graph.adts.new(adt_params)

    if @adt.save
      @adt.update_data_csv
      #AdtWorker.perform_async(@adt.id)
      redirect_to category_graph_path(@category,@graph),  :flash => { :success => 'Data Series was successfully created.'}
    else
      render :new
    end
  end

  # PATCH/PUT /graphs/1
  def update
    #debugger
    if @adt.update(adt_params)
      redirect_to category_graph_path(@category,@graph),  :flash => { :success => 'Data Series was successfully updated.'}
    else
      render :edit
    end
  end

  # DELETE /graphs/1
  def destroy
    @adt.destroy
    redirect_to category_graph_path(@category,@graph),  :flash => { :success => 'Data Series was successfully destroyed.'}
  end

  def update_data

    @category = Category.find(params[:category_id])
    @graph    = Graph.find(params[:graph_id])
    @adt      = Adt.find(params[:adt_id])
    @adt.adt_datums.delete_all
    # @new_adt     = Adt.new
    # @new_adt.id  = @adt.id

    # @new_adt.graph_id  = @adt.graph_id
    # @new_adt.name      = @adt.name
    # @new_adt.x_colname = @adt.x_colname
    # @new_adt.y_colname = @adt.y_colname
    # @new_adt.sheetname = @adt.sheetname
    # @new_adt.y_legend  = @adt.y_legend
    # @new_adt.color_y   = @adt.color_y
    # @new_adt.order_num = @adt.order_num

    # @adt.destroy

    # if @new_adt.save
    @adt.update_data_csv
    #GraphWorker.perform_async(params[:graph_id])
    redirect_to category_graph_path(@category,@graph),  :flash => { :success => 'Data Series was successfully updated.'}
    #end
                                   
  end 

  def api_get_adt_data
    @data   = []
    
    adt   = Adt.find(params[:adt_id])

    data = adt.adt_datums.order('timestamp_ms asc').pluck(:timestamp_ms,:y1_values)
      
    respond_to do |format|
      format.json  { render :json => data } 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_breadcrumb
      add_breadcrumb "Graphs", category_path(@category)
      add_breadcrumb "Data Series", category_graph_path(@category, @graph)
    end

    def set_adt
      @category = Category.find(params[:category_id])
      @graph    = @category.graphs.find(params[:graph_id])
      @adt      = @graph.adts.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def adt_params
      params.require(:adt).permit([
                                   :name,
                                   :x_colname,
                                   :y_colname,
                                   :sheetname,
                                   :y_legend,
                                   :color_y,
                                   :order_num,
                                   :graph_type
                                   ])
      
    end
end
