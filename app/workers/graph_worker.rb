class GraphWorker
	include Sidekiq::Worker

	def perform(graph_id)
		graph = Graph.find(graph_id)
		graph.update_data
	end
end