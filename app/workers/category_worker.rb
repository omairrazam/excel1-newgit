class CategoryWorker
	include Sidekiq::Worker
	def perform(category_id)
		category     = Category.find(category_id)

    	category.sp_graphs.delete_all
    	status = category.fetch_sp_csv

	    if status == -1
	    	puts "-----------------Sheed doesn't exist-----------------"
	    	return
	    elsif status == -2
	    	puts "-----------------Column name(s) not correct------------"
	      	return
	    end

	    @category.graphs.each do |g|
	      g.adts.each do |a|
	        a.adt_datums.delete_all
	        a.update_data_csv
	      end
	    end

	    puts "---------------------end of category update worker------------"
    	
	end
end