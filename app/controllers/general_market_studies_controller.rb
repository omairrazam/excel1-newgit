class GeneralMarketStudiesController < ApplicationController
  before_action :set_general_market_study, only: [:show, :edit, :update, :destroy]

  # GET /general_market_studies
  def index
    @general_market_studies = GeneralMarketStudy.all.page(params[:page]).per(5)
  end

  # GET /general_market_studies/1
  def show
  end

  # GET /general_market_studies/new
  def new
    @general_market_study = GeneralMarketStudy.new
  end

  # GET /general_market_studies/1/edit
  def edit
  end

  # POST /general_market_studies
  def create
    @general_market_study = GeneralMarketStudy.new(general_market_study_params)

    if @general_market_study.save
      redirect_to @general_market_study, notice: 'General market study was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /general_market_studies/1
  def update
    if @general_market_study.update(general_market_study_params)
      redirect_to @general_market_study, notice: 'General market study was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /general_market_studies/1
  def destroy
    @general_market_study.destroy
    redirect_to general_market_studies_url, notice: 'General market study was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_general_market_study
      @general_market_study = GeneralMarketStudy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def general_market_study_params
      params.require(:general_market_study).permit(:title, :content)
    end
end
