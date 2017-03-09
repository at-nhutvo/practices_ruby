require "csv"
require "date"

class HandleError
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

class ReadFile
	def initialize(source)
		# TODO: Check exists file
		raise "Not Found" unless File.exists?(source)
		rescue
			HandleError.not_found
		else
			@source = source
	end

	def get_data
		lines = File.readlines(@source)

		# Transfer data to array
		data = []
		lines.each do |line|
			item = line.chomp.split('/')
			item << calculate_age(item[2])
			data << item
		end
		return data
	end

	private 

	def calculate_age(string)
		Date.parse(string) 
		rescue
			HandleError.invalid_date
		else
			year_birthday = Date.parse(string).year
			year_current  = Time.now.year
			year_current - year_birthday
	end
end

class Export
	def initialize(data, columns)
		@data    = data
		@columns = columns
	end

	def do_export
		# TODO: Export file
		CSV.open(filename, 'w') do |csv|
			# Add columns
			csv << @columns

			# Sort data
			data = sort_order(@data, 3) 

			# Add row
			data.each do |row|
				csv << row
			end
			puts 'Great! Create file csv successfully!'
		end
		rescue
			HandleError.not_write_file
	end

	private

	def filename
		# TODO: Create filename by format
		time = Time.now
		time.strftime('%Y%m%d%H%M%S') << '.csv'
	end

	def sort_order(data, order_by = 0, pos = 'asc')
		pos == 'asc'? data.sort{ |a,b| a[order_by] <=> b[order_by] } : data.sort{ |a,b| b[order_by] <=> a[order_by] }
	end
end

# TODO: Prepare
SOURCE = 'data_master.txt'
COLUMNS = %w(ID Fullname Birthday Team Age).freeze

# TODO: Read file, get data
file = ReadFile.new(SOURCE)
source_data = file.get_data
# TODO: Export 
x = Export.new(source_data, COLUMNS)
x.do_export
