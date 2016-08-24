class GraphsController < ApplicationController
  before_action :set_graph, only: [:show, :edit, :update, :destroy]

  # GET /graphs
  def index
    @graphs = Graph.all
  end

  # GET /graphs/1
  def show
  end

  # GET /graphs/new
  def new
    @category   =  Category.find(params[:category_id])
    @graph      =  @category.graphs.new
  end

  # GET /graphs/1/edit
  def edit
  end

  # POST /graphs
  def create
    @category   =  Category.find(params[:category_id])
    @graph      =  @category.graphs.new(graph_params)

    if @graph.save
      #GraphWorker.perform_async(@graph.id)
      @graph.update_data_csv
      redirect_to category_path(@category), notice: 'Graph was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /graphs/1
  def update
    #debugger
    if @graph.update(graph_params)
      redirect_to category_path(@category), notice: 'Graph was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /graphs/1
  def destroy
    @graph.destroy
    redirect_to category_path(@category), notice: 'Graph was successfully destroyed.'
  end

  def update_data
    @category = Category.find(params[:category_id])
    @graph    = Graph.find(params[:graph_id])
   
    @new_graph      = Graph.new

    @new_graph.name = @graph.name
    @new_graph.id   = @graph.id
    @new_graph.x_colname  = @graph.x_colname
    @new_graph.y1_colname = @graph.y1_colname
    @new_graph.y2_colname = @graph.y2_colname
    @new_graph.color_y1   = @graph.color_y1
    @new_graph.color_y2   = @graph.color_y2
    @new_graph.order_num  = @graph.order_num
    @new_graph.sheetname  = @graph.sheetname
    @new_graph.y1_legend  = @graph.y1_legend
    @new_graph.y2_legend  = @graph.y2_legend
    @new_graph.category_id = @graph.category_id
   
    @graph.destroy

    if @new_graph.save
      @new_graph.update_data_csv
      redirect_to category_path(@category),  :flash => { :success => 'Graph Data was successfully updated.'}
    end
    
  end 

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      #debugger
      @category = Category.find(params[:category_id])
      @graph    = @category.graphs.find(params[:id])
    end

    def verify_sheet_exists
      if File.exist?(Rails.root.to_s +  "/excelsheet/actual.csv") 
      else 
        redirect_to categories_path,  :flash => { :alert => 'No File.'}
      end
    end

    # Only allow a trusted parameter "white list" through.
    def graph_params
      
      params.require(:graph).permit([
                                                           :name,
                                                           :x_colname,
                                                           :y1_colname,
                                                           :y2_colname,
                                                           :sheetname,
                                                           :y1_legend,
                                                           :y2_legend, 
                                                           :color_y1,
                                                           :color_y2,
                                                           :order_num])
      
    end
end
