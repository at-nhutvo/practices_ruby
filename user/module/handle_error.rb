module HandleError
	def self.who_am_i?
		"#{self.type.name} (\##{self.id}): #{self.to_s}"
	end
  
	def self.not_found
		puts "Source File Not Found"
		exit
	end

	def self.not_write_file
		puts 'Opps! Create file csv failed!'
		exit
	end

	def self.invalid_date
		puts 'Invalid date'
		exit
	end
end
