class CategoryWorker
	include Sidekiq::Worker
	include Sidekiq::Status::Worker

	def perform(c_id)
		# the common idiom to track progress of your task
	    total 100 # by default

	    # a way to associate data with your job
	    store vino: 'veritas'

	    # a way of retrieving said data
	    # remember that retrieved data is always String|nil
	    vino = retrieve :vino


		category     = Category.find(c_id)
		puts "-----------------------------Updation of #{category.name} starts------------"
    	category.sp_graphs.delete_all
    	status = category.fetch_sp_csv

	    if status == -1
	    	puts "-----------------Sheet doesn't exist-----------------"
	    	return
	    elsif status == -2
	    	puts "-----------------Column name(s) not correct------------"
	      	return
	    end

	    current_progress = 20
	    at current_progress, "#{current_progress} %"
	    
	    total_datasets_count = 0
	    category.graphs.each do |g|
	    	total_datasets_count += g.adts.count
	    end
	    
	    unit_progress = 80/total_datasets_count

	    category.graphs.each do |g|
	      g.adts.each do |a|
	      	"-----------------deleting old data of ADT #{a.name} starts------------"
	        a.adt_datums.delete_all
	        "-----------------update of ADT #{a.name} starts------------"
	        a.update_data_csv
	        "----------------- ADT #{a.name} data updates end------------"
	        current_progress += unit_progress
	        at current_progress, "#{current_progress}%"
	      end
	    end

	    puts "---------------------end of #{category.name} ends------------"
    	
	    at 100, "Done"

	end
end

