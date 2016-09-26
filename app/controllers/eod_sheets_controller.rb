class EodSheetsController < BaseAdminController
  before_filter :set_category, only: [:index, :new, :create, :update, :edit, :destroy]
  

  def index
    @eod_sheets = @category.eod_sheets
  end

  # GET /eod_sheets/new
  def new

    @eod_sheet = @category.eod_sheets.build
  end

  # POST /eod_sheets
  def create
    @eod_sheet = @category.eod_sheets.build(eod_sheet_params)
    
    if @eod_sheet.save
      redirect_to category_eod_sheets_path(@category), notice: 'Eodsheet was successfully created.'
    else
      render :new
    end
  end

  def edit
    @eod_sheet = @category.eod_sheets.find(params[:id])
  end

  def update
    @eod_sheet = @category.eod_sheets.find(params[:id])
    
    if @eod_sheet.update(eod_sheet_params)
      redirect_to category_eod_sheets_path(@category), notice: 'Eodsheet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @eod_sheet = @category.eod_sheets.find(params[:id])
    @eod_sheet.destroy!
    redirect_to category_eod_sheets_path(@category), notice: 'Eodsheet was successfully destroyed'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def eod_sheet_params
      params.require(:eod_sheet).permit(:filename,:datee)
    end

    def set_category
      @category   = Category.find(params[:category_id])
      add_breadcrumb "Categories", :categories_path
      add_breadcrumb @category.name, category_path(@category)
      add_breadcrumb "Sheets", category_eod_sheets_path(@category)
    end
end
