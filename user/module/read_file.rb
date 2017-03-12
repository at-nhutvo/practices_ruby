module ReadFile
	def read_data(source)
		file = validate_source(source)
		lines = File.readlines(file)

		# Transfer data to array
		data = []
		lines.each do |line|
			item = line.chomp.split('/')
			calculate_age(item[2])
			item << calculate_age(item[2])
			data << item
		end
		return data
	end

	def validate_source(source)
		begin
			raise "Source Not Found" unless File.exists?(source)
			source
			rescue Exception => e
				puts e; exit
		end
	end

	private

	def calculate_age(string)
		begin
			Date.parse(string) 
			year_birthday = Date.parse(string).year
			year_current  = Time.now.year
			year_current - year_birthday
		rescue Exception => e
			puts e
			exit
		end
	end

end