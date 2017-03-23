module User
	@table = 'user'

	def self.add_user(name)
		code = srand.to_s[0..3]
		data = {code: code, name: name}
		last_id = DB.insert(@table, data)
		if last_id
			code = last_id.to_s << code
			DB.update(@table, {code: code}, "id = #{last_id}")
			"Registration successful. Your ID/Name: #{code}/#{name}"
		else
			"Registration failed"
		end
	end


	def self.update_money(money, code)
		DB.update(@table, {money: money}, "code = #{code}")
	end

	def self.select_list_user
		DB.select(@table, {order: 'id DESC'})
	end

	def self.select_a_user(id)
		DB.select(@table, {select: '*', where: "id = #{id}"})
	end

	def self.update_user(id, data)
		DB.update(@table, data, "id = #{id}")
	end

	def self.delete_user(id)
		DB.delete(@table, id)
	end
end # module