module Template
	def self.show_menu_1
		puts %{			Please, choose option after:
				--------------------------------
				1. Add new user
				2. Select user
				3. Show list user
				4. Exit
				--------------------------------
				Enter:
			}
	end

	def self.show_menu_2
		puts %{		Please, choose option after:
			--------------------------------
			1. Check your money
			2. Remittance (Chuyen tien)
			3. Withdraw cash (Rut tien)
			4. Add money to your account
			5. Come back
			6. Exit
			--------------------------------
			Enter:
		}
	end

	def self.get_info_input
		yield
		gets.chomp
	end
end