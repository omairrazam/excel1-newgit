class CategoryWorker
	include Sidekiq::Worker
	def perform(category_id)
		category = Category.find(category_id)
		category.fetch_sp_graph
	end
end