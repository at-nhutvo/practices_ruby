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

	def select(table, options)
		query = "SELECT "
		query += options[:select].nil? ? '*' : "#{options[:select]}"
		query += " FROM #{table}"
		query += " WHERE #{options[:where]}" unless options[:where].nil?
		query += options[:order].nil? ? " ORDER BY id DESC" : " ORDER BY #{options[:order]}"
		query = @db.escape(query)
		data = @db.query(query).each
		data = data.empty? ? false : data
	end

	def insert(table, inputs)
		begin 
			raise "Data must is hash" unless inputs.is_a?(Hash)
			columns = ''
			values = ''
			inputs.each do |k, v|
				columns += "#{k},"
				values += "'#{v}',"
			end
			# trim comma
			columns = columns.chomp(',')
			values= values.chomp(',')
			query = "INSERT INTO #{table}(#{columns}) VALUES(#{values})"
			@db.query(query)
			@db.affected_rows ? @db.last_id : false
		rescue Exception => msg
			puts msg
		end
	end

	def update(table, inputs, condition = '')
		begin 
			raise "Data must is hash" unless inputs.is_a?(Hash)
			data = ''
			inputs.each do |col, val|
				data += "#{col} = '#{val}',"
			end
			# trim comma
			data  = data.chomp(',')
			query = condition.empty? ? "UPDATE #{table} SET #{data}" : "UPDATE #{table} SET #{data} WHERE #{condition}"
			@db.query(query)
			@db.affected_rows ? true : false
		rescue Exception => msg
			puts msg
		end
	end

	def delete(table, condition)
		condition = condition.is_a?(Integer) ? "id = #{condition}" : condition
		query = "DELETE FROM #{table} WHERE #{condition}"
		@db.query(query)
		@db.affected_rows ? true : false
	end

	def do_query(str)
		@db.query(str)
		@db.affected_rows ? true : false
	end

	def transaction
		raise ArgumentError, "No block was given" unless block_given?
		begin
			@db.query("BEGIN")
			yield
			@db.query("COMIT")
		rescue
			@db.query("ROLLBACK")
		end
	end
end


