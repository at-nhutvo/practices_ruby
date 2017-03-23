class HomeController
	def call(env)
		@request = Rack::Request.new(env)
		if @request.get? && @request.path == '/'
			index
		else
			Rack::Response.new('File not found', 404)
		end
	end

	def index
		template = File.read('app/views/home.html.erb')
		result = ERB.new(template).result(binding)
		Rack::Response.new(result)
	end
end