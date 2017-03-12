class UserController
	include ReadFile
	@@table = 'user'

	def run; call_template end

	private

	def call_template
		puts %{		Please, choose option after:
			--------------------------------
			1. Create table user
			2. Read file and insert data into table user
			3. Show data
			4. Show menu
			5. Exit
			--------------------------------
			Enter:
		}
		yield(do_confirm)
	end

	def input_source
		puts 'Please choose file! (data_master.txt)'
		gets.chomp
	end

	def do_confirm
		case gets.chomp
		when '1' # 1: Create table
			generate_table
			call_template
		when '2' # 2: read & insert
			source = input_source 
			data = read_source(source)
			save(data)
			call_template
		when '3' # 3: show data
			show
			call_template
		when '4' # 4: show menu
			call_template{do_confirm} 
		else exit
		end
	end

	def save(data)
		data.each_with_index do |item, i|
			data = {code: item[0], name: item[1], birthday: item[2], team: item[3]}
			puts DB.insert(@@table, data) ? "Insert data successfully!" : 'Oops! Insert data failed!'
		end
	end

	def show
		data = DB.select(@@table)
		data.each do |i| 
			puts %{Code: #{i["code"]} - Name: #{i["name"]} - Birthday: #{i["birthday"]} - Team: #{i["team"]}}
		end
	end

	def read_source(source); read_data(source) end

	def generate_table
		# Structure of table `user`
		sql = %{
			CREATE TABLE IF NOT EXISTS `#{@@table}` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `birthday` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `team` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
		}
		DB.do_query(sql) ? 'Create table successfully!' : 'Oops! Create table failed!'
	end
end

