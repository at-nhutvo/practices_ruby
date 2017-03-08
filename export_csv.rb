class Export_AT
	def initialize f_source, f_des = ''
		@f_source = f_source
		if f_des.empty?
			time = Time.now
			@f_des = time.strftime('%Y%m%d%H%M%S') + '.xls'
		else
			validate_filename(f_des)
		end
	end

	def validate_filename(f_des)
		accept_format = [".xls"]
		if accept_format.include? File.extname(f_des)
			@f_des = f_des
		else
			puts "Invalid Format File"
			exit
		end
	end

	def file_exists
		begin
			if ! (File.exists? @f_source); raise "File not found" end
		rescue => e
			puts "Error: #{e}"
		end
	end

	def get_data
		begin
			file_exists
			return File.readlines(@f_source)
		rescue => e
			puts "Error readlines: #{e}"
		end
	end

	def sort_order(data, order_by = 0, pos = 'asc')
		if pos == 'asc'
			data = data.sort{ |a,b| a[order_by] <=> b[order_by] }
		else
			data = data.sort{ |a,b| b[order_by] <=> a[order_by] }
		end
		return data
	end

	def add_row(data, csv)
		write = nil
		data.each do |item|
			year = get_year(item[2])
			year = (Time.new.year - year).to_s

			item.push(year)
			write = csv << item.map!(&:capitalize)
		end
		puts write ? 'Great! Create file csv successfully!' : 'Opps! Create file csv failed!'

	end

	def get_year(date)
		regex = /^[0-9]{2}+-[0-9]{2}+-[0-9]{4}/
		d = "#{date}".match(regex)
		if d.nil?
			puts "Invalid Format Date"
		else
			d = d.to_s
			return d[-4..-1].to_i
		end
	end

	def add_columns(columns, csv)
		csv << columns # Add Column
	end

	def do_export_csv(*columns)
		require 'csv'
		CSV.open(@f_des, 'w+') do |csv|
			
			add_columns(columns, csv)

			# Doc du lieu tu file txt, sau do luu DL vao mang
			data = Array.new
			get_data.each do |line|
				row = line.chomp.split('/')
				data << row
			end

			# Sort data
			data = sort_order(data, 3) 
			
			# Add row
			add_row(data, csv)
		end
	end
end

f_source = 'data_master.txt'
file = Export_AT.new(f_source)
file.do_export_csv("ID", "Fullname", "Birthday", "Team", "Yearsold")

