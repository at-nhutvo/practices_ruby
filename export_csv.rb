class Export_AT
	def initialize f_source, f_des = ''
		@f_source = f_source
		@f_des    = f_des
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

	def order(data, order_by = 0, pos = 'asc')
		if pos == 'asc'
			data = data.sort{ |a,b| a[order_by] <=> b[order_by] }
		else
			data = data.sort{ |a,b| b[order_by] <=> a[order_by] }
		end
		return data
	end

	def do_export_csv(*columns)
		require 'csv'
		CSV.open(@f_des, 'w+') do |csv|
			
			csv << columns # Add Column

			# Doc du lieu tu file txt, sau do luu DL vao mang
			data = Array.new
			get_data.each do |line|
				row = line.chomp.split('/')
				data << row
			end

			# Sort data
			data = order(data, 3) 
			
			# Add row 
			write = nil
			data.each do |a|
				write = csv << a.map!(&:capitalize)
			end
			puts write ? 'Great! Create file csv successfully!' : 'Opps! Create file csv failed!'

		end
	end
end

f_source = 'data_master.txt'
f_des    = 'users.xls'

file = Export_AT.new(f_source, f_des)
file.do_export_csv("ID", "Fullname", "Birthday", "Team")
