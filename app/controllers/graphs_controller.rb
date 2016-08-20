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
    graph = Graph.find(params[:graph_id])
    graph.update_data
    redirect_to category_path(graph.category), success: 'Graph data has loaded'
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      #debugger
      @category = Category.find(params[:category_id])
      @graph    = @category.graphs.find(params[:id])
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
                                                           :color_y2])
      
    end
end
