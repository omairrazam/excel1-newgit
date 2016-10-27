class MarketStudiesController < BaseAdminController
  before_action :set_market_study, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only:[:show]
  skip_authorize_resource :only => :download_image
  #skip_authorization_check
  # GET /market_studies
  def index
    @market_studies = MarketStudy.all.order("created_at desc").page(params[:page]).per(5)
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
    @friendly_url = @market_study.build_friendly_url(friendly_url_params)
    
    

    respond_to do |format|
      if @friendly_url.save
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

  def download_image
    market_study = MarketStudy.find(params[:id])
    send_file "#{Rails.root}/public#{market_study.image_url}", :type=>"application/png", :x_sendfile=>true
    #redirect_to :back
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_study
      @market_study = MarketStudy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def market_study_params
      params.require(:market_study).permit(:title, :content,:typee, :price_target, :image)
    end

     def friendly_url_params
      params.require(:friendly_url).permit(:slug)
    end
end
