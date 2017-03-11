class UserController
	include HandleError, ReadFile

	def run
		data = read_data(@source)
	end

	def set_source(source); @source = source end
end

