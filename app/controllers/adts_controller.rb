class AdtsController < ApplicationController
	before_action :set_adt, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /graphs/1/edit
  def edit
  end

  # POST /graphs
  def create
  	@category =  Category.find(params[:category_id])
    @graph    =  @category.graphs.find(params[:graph_id])
    @adt      =  @graph.adts.new(adt_params)

    if @adt.save
      AdtWorker.perform_async(@adt.id)
      redirect_to category_graph_path(@category,@graph),  :flash => { :success => 'Adt was successfully created.'}
    else
      render :new
    end
  end

  # PATCH/PUT /graphs/1
  def update
    #debugger
    if @adt.update(adt_params)
      redirect_to category_graph_path(@category,@graph),  :flash => { :success => 'Adt was successfully updated.'}
    else
      render :edit
    end
  end

  # DELETE /graphs/1
  def destroy
    @adt.destroy
    redirect_to category_graph_path(@category,@graph),  :flash => { :success => 'Adt was successfully destroyed.'}
  end

  def update_data
    AdtWorker.perform_async(params[:adt_id])

  end 

  private
    # Use callbacks to share common setup or constraints between actions.
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
                                   :color_y
                                   ])
      
    end
end
