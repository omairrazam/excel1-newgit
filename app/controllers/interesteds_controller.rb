class InterestedsController < ApplicationController
  before_action :set_interested, only: [:show, :edit, :update, :destroy]

  # GET /interesteds
  # GET /interesteds.json
  def index
    @interested = Interested.first
  end

  # GET /interesteds/1
  # GET /interesteds/1.json
  def show
  end

  # GET /interesteds/new
  def new
    @interested = Interested.new
  end

  # GET /interesteds/1/edit
  def edit
  end

  # POST /interesteds
  # POST /interesteds.json
  def create
    @interested = Interested.new(interested_params)

    respond_to do |format|
      if @interested.save
        format.html { redirect_to @interested, notice: 'Interested was successfully created.' }
        format.json { render :show, status: :created, location: @interested }
      else
        format.html { render :new }
        format.json { render json: @interested.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interesteds/1
  # PATCH/PUT /interesteds/1.json
  def update
    respond_to do |format|
      if @interested.update(interested_params)
        format.html { redirect_to @interested, notice: 'Interested was successfully updated.' }
        format.json { render :show, status: :ok, location: @interested }
      else
        format.html { render :edit }
        format.json { render json: @interested.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interesteds/1
  # DELETE /interesteds/1.json
  def destroy
    @interested.destroy
    respond_to do |format|
      format.html { redirect_to interesteds_url, notice: 'Interested was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interested
      @interested = Interested.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interested_params
      params.require(:interested).permit(:content)
    end
end
