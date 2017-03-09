require 'csv'

class HandleError < StandardError
end

class Validate
	def self.is_excel(source)
		# TODO
		# Validate format file excel
		accept_format = [".xls, .csv"]

	end

	def self.exists(source)
		# TODO: Check exists file 
		raise HandleError, "Source file not found"  if !File.exists?(source)
	end

	def self.date(date)
		regex = /^[0-9]{2}+-[0-9]{2}+-[0-9]{4}/
		d = "#{date}".match(regex)
		raise HandleError, "Invalid Format Date" if d.nil?
	end

end

class Read
	def initialize(source)
		Validate.exists(source)
		rescue HandleError => error
			puts error
		else
			@source = source
	end

	def get_data
		File.readlines(@source)
	end

	def get_year(date)
		d = Validate.date(date)
		rescue HandleError => e
			puts e
		else
			d = d.to_s
			d[-4..-1].to_i
	end
end

class Export < Read
	def initialize(source)
		super
	end

	def do_export(data, columns)
		# TODO: Export file
		new_data = []
		file = get_filename

		CSV.open(file, 'w+') do |csv|
			# Add columns
			csv << columns

			# Read line then add array data
			data.each do |line|
				row = line.chomp.split('/')
				new_data << row
			end

			# Sort data
			data = sort_order(new_data, 3) 

			# Add row
		puts add_row(data, csv) ? 'Great! Create file csv successfully!' : 'Opps! Create file csv failed!'
		end
		
	end

	private

	def get_filename
		# TODO: Create filename by format
		time = Time.now
		time.strftime('%Y%m%d%H%M%S') << '.csv'
	end

	def sort_order(data, order_by = 0, pos = 'asc')
		pos == 'asc'? data.sort{ |a,b| a[order_by] <=> b[order_by] } : data.sort{ |a,b| b[order_by] <=> a[order_by] }
	end

	def add_row(data, csv)
		data.each do |item|
			year = get_year(item[2])
			year = (Time.new.year - year).to_s

			item.push(year)
			csv << item.map!(&:capitalize)
		end
	end
end


# TODO: Prepare
source = 'data_master.txt'
columns = %w(ID Fullname Birthday Team Yearsold)

# TODO: Execute
file = Export.new(source)
data = file.get_data
file.do_export(data, columns)
