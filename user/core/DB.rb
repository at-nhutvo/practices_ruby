require "mysql2"

class Database
	def initialize(db_host, db_user, db_password, db_database)
		begin
			@db = Mysql2::Client.new(:host => db_host, :username => db_user, :password => db_password, :database => db_database)
		raise "Error: Could't connect to database" unless @db
		rescue Exception => msg
			puts msg
			exit
		end
	end

	def affected_rows; @db.affected_rows end

	def set_table(table); @table = table end

	def select(str = '*', where = '')
		if where.size != 0
			@db.query("SELECT #{str} FROM #{@table} WHERE #{where}")
		else
			@db.query("SELECT #{str} FROM #{@table}")
		end
	end

	def insert(array)
		begin 
			raise "Data must is hash" unless array.is_a?(Hash)
			columns = ''
			values = ''
			array.each do |k, v|
				columns += "#{k},"
				values += "'#{v}',"
			end
			# trim comma
			columns = columns.chomp(',')
			values= values.chomp(',')
			query = "INSERT INTO #{@table}(#{columns}) VALUES(#{values})"
			res = @db.query(query)
			affected_rows ? @db.last_id : false
		rescue Exception => msg
			puts msg
		end
	end

	def update(data, where = '')
		begin 
			raise "Data must is hash" unless data.is_a?(Hash)
			data = ''
			data.each do |col, val|
				data += "#{col} = '#{val}',"
			end
			# trim comma
			data = data.chomp(',')
			if where.size != 0
				query = "UPDATE #{@table} SET #{data} WHERE #{where}"
			else
				query = "UPDATE #{@table} SET #{data}"
			end
			res = @db.query(query)
			affected_rows ? @db.last_id : false
		rescue Exception => msg
			puts msg
		end
	end

	def delete(where)
		where = where.is_a?(Integer) ? "id = #{where}" : where
		query = "DELETE FROM #{@table} WHERE #{where}"
		affected_rows ? true : false
	end
end