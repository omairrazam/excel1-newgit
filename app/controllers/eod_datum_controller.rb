class EodDatumController < BaseAdminController
	
	def update
		@eod = EodDatum.find(params[:id])
		#debugger
		respond_to do |format|
			if @eod.update(eod_params)
		    	format.json { render status: :ok    }
			end
		end
	    
  	end

  	private

  	def eod_params
      params.require(:eod).permit(:order_number)
    end
end
