module ReadFile
	def read_data(source)
		source = valid_source(source)
		exit
		lines = File.readlines(source)

		# Transfer data to array
		data = []
		lines.each do |line|
			item = line.chomp.split('/')
			item << calculate_age(item[2])
			data << item
		end
		return data
	end

	def valid_source(source)
		include HandleError
		# TODO: Check exists file
		raise "Not Found" unless File.exists?(source)
		rescue
			HandleError.not_found
		else
			# source
			puts "cc"
	end

	def calculate_age(string)
		include HandleError

		Date.parse(string) 
		rescue
			HandleError.invalid_date
		else
			year_birthday = Date.parse(string).year
			year_current  = Time.now.year
			year_current - year_birthday
	end
end