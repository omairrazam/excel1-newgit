class GeneralMarketStudiesController < BaseAdminController
  before_action :set_general_market_study, only: [:show, :edit, :update, :destroy]

  # GET /general_market_studies
  def index
    @general_market_studies = GeneralMarketStudy.all.order("created_at desc").page(params[:page]).per(5)
  end

  # GET /general_market_studies/1
  def show
  end

  # GET /general_market_studies/new
  def new
    @general_market_study = current_user.general_market_studies.build
  end

  # GET /general_market_studies/1/edit
  def edit
  end

  # POST /general_market_studies
  def create
    @general_market_study = current_user.general_market_studies.build(general_market_study_params)
    @friendly_url = @general_market_study.build_friendly_url(friendly_url_params)

    if @friendly_url.save
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
      params.require(:general_market_study).permit(:title, :content, :category)
    end

    def friendly_url_params
      params.require(:friendly_url).permit(:slug)
    end
end
