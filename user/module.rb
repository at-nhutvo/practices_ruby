def vs
	source = './data_master.txt'
	# TODO: Check exists file
	raise "Not Found" unless File.exists?(source)
	rescue Exception => e
		puts e
	else
		puts "success"
end
