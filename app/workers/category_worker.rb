class CategoryWorker
	include Sidekiq::Worker

	def perform(c_id)
		category     = Category.find(c_id)
		puts "-----------------------------Updation of #{category.name} starts------------"
    	category.sp_graphs.delete_all
    	status = category.fetch_sp_csv

	    if status == -1
	    	puts "-----------------Sheed doesn't exist-----------------"
	    	return
	    elsif status == -2
	    	puts "-----------------Column name(s) not correct------------"
	      	return
	    end

	    category.graphs.each do |g|
	      g.adts.each do |a|
	      	"-----------------deleting old data of ADT #{a.name} starts------------"
	        a.adt_datums.delete_all
	        "-----------------update of ADT #{a.name} starts------------"
	        a.update_data_csv
	        "----------------- ADT #{a.name} data updates end------------"
	      end
	    end

	    puts "---------------------end of #{category.name} ends------------"
    	
	end
end