class ExcelsheetsController < BaseAdminController
  

  # GET /excelsheets/new
  def new
    #delete existing one
    @category   = Category.find(params[:category_id])
    if @category.excelsheet.present?
      @category.excelsheet.delete
    end
    @excelsheet = @category.build_excelsheet
  end

  # GET /excelsheets/1/edit
  def edit
  end

  # POST /excelsheets
  def create
    @category   = Category.find(params[:category_id])
    @excelsheet = @category.build_excelsheet(excelsheet_params)

    if @excelsheet.save
      redirect_to category_path(@category), notice: 'Excelsheet was successfully created.'
    else
      render :new
    end
  end



  private

    # Only allow a trusted parameter "white list" through.
    def excelsheet_params
      params.require(:excelsheet).permit(:filename)
    end
end
