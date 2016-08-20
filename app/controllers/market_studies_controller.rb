class MarketStudiesController < ApplicationController
  before_action :set_market_study, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin_user!, only:[:create, :update , :delete, :new]
  before_filter :authenticate_user!, only:[:show]
  # GET /market_studies
  def index
    
    @market_studies = MarketStudy.all.page(params[:page]).per(5)
  end

  # GET /market_studies/1
  def show
  end

  # GET /market_studies/new
  def new
    @market_study = current_user.market_studies.build
  end

  # GET /market_studies/1/edit
  def edit
  end

  # POST /market_studies
  def create
    @market_study = current_user.market_studies.build(market_study_params)
    respond_to do |format|
      if @market_study.save
        format.html { redirect_to @market_study, notice: 'Commentary was successfully created.' }
        format.json { render :show, status: :created, location: @market_study }
      else
        format.html { render :new }
        format.json { render json: @market_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market_studies/1
  def update
    if @market_study.update(market_study_params)
      redirect_to @market_study, notice: 'Market study was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /market_studies/1
  def destroy
    @market_study.destroy
    redirect_to market_studies_url, notice: 'Market study was successfully destroyed.'
  end

  def active_studies
    authenticate_user!
    @active_studies = MarketStudy.all.page(params[:page]).per(20)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_study
      @market_study = MarketStudy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def market_study_params
      params.require(:market_study).permit(:title, :content,:typee, :price_target)
    end
end
