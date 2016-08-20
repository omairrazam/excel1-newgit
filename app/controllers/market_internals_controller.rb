class MarketInternalsController < ApplicationController
  before_action :set_market_internal, only: [:show, :edit, :update, :destroy]

  # GET /market_internals
  def index
    @market_internals = MarketInternal.all.page(params[:page]).per(5)
  end

  # GET /market_internals/1
  def show
  end

  # GET /market_internals/new
  def new
    @market_internal = MarketInternal.new
  end

  # GET /market_internals/1/edit
  def edit
  end

  # POST /market_internals
  def create
    @market_internal = MarketInternal.new(market_internal_params)

    if @market_internal.save
      redirect_to @market_internal, notice: 'Market internal was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /market_internals/1
  def update
    if @market_internal.update(market_internal_params)
      redirect_to @market_internal, notice: 'Market internal was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /market_internals/1
  def destroy
    @market_internal.destroy
    redirect_to market_internals_url, notice: 'Market internal was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_internal
      @market_internal = MarketInternal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def market_internal_params
      params.require(:market_internal).permit(:title, :content)
    end
end
