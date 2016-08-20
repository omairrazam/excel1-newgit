class ExcelsheetsController < ApplicationController
  before_action :set_excelsheet, only: [:show, :edit, :update, :destroy]

  # GET /excelsheets
  def index
    @excelsheets = Excelsheet.all
  end

  # GET /excelsheets/1
  def show
  end

  # GET /excelsheets/new
  def new
    @excelsheet = Excelsheet.new
  end

  # GET /excelsheets/1/edit
  def edit
  end

  # POST /excelsheets
  def create
    @excelsheet = Excelsheet.new(excelsheet_params)

    if @excelsheet.save
      redirect_to @excelsheet, notice: 'Excelsheet was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /excelsheets/1
  def update
    if @excelsheet.update(excelsheet_params)
      redirect_to @excelsheet, notice: 'Excelsheet was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /excelsheets/1
  def destroy
    @excelsheet.destroy
    redirect_to excelsheets_url, notice: 'Excelsheet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excelsheet
      @excelsheet = Excelsheet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def excelsheet_params
      params.require(:excelsheet).permit(:filename)
    end
end
