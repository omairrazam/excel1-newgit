class AdtWorker 
	include Sidekiq::Worker

	def perform(adt_id)
		adt = Adt.find(adt_id)
		adt.update_data
	end
end