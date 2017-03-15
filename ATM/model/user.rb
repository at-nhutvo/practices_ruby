module User
	@table = 'user'

	def self.add_user(name)
		code = srand.to_s[0..3]
		data = {code: code, name: name}
		last_id = DB.insert(@table, data)
		if last_id
			code = last_id.to_s << code
			DB.update(@table, {code: code}, "id = #{last_id}")
			puts "Registration successful. Your ID/Name: #{code}/#{name}"
		else
			puts "Registration failed"
		end
	end

	def self.login(code)
		DB.select(@table, {where: "code = #{code}"})
	end

	def self.select_money(code)
		data = DB.select(@table, {select: 'money', where: "code = #{code}"})
		data.empty? ? false : data[0]["money"].to_i
	end

	def self.update_money(money, code)
		DB.update(@table, {money: money}, "code = #{code}")
	end

	def self.show_list_user
		DB.select(@table, {order: 'money ASC'})
	end

	def self.select_code(code)
		DB.select(@table, {select: 'code', where: "code = #{code}"})
	end

end # module