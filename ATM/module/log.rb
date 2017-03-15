module Log
	class Read
		def read_data(source = LOG_FILE)
			file = validate_source(source)
			lines = File.readlines(file)

			# Transfer data to array
			data = []
			lines.each do |line|
				item = line.chomp.split('/')
				data << item
			end
			return data
		end

		private

		def validate_source(source)
			begin
				raise "Source Not Found" unless File.exists?(source)
				source
				rescue Exception => e
					puts e; exit
			end
		end
	end

	class Write
		def initialize
			# TOTO: check exists file log
			if !File.exists?(LOG_FILE)
				File.open(LOG_FILE, 'w') do |file|
					file.puts "Time/Action/ID User/ID Receiver"
				end
			end
		end

		def self.run(data)
			File.open(LOG_FILE, 'a') do |file|
				time     = Time.now
				user     = data[:user].nil? ? '-' : data[:user]
				receiver = data[:receiver].nil? ? '-' : data[:receiver]
				file.puts "#{time}/#{data[:action]}/#{user}/#{receiver}"
			end
		end
	end

end