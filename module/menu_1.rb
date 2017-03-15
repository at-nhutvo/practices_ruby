module Menu1
	class Action
		def callback
			Template::show_menu_1
			do_confirm
		end

		private

		def add_user
			# TODO: write log
			Log::Write.run({action: 'Add user'})

			# TODO: Action add user
			flat = true
			while flat do
				name = Template::get_info_input{puts 'Please input name:'}
				if name.size > 4
					flat = false
					User::add_user(name)
					callback
				else
					flat = true
					puts "Message: Name is required large 4 character"
				end
			end
		end # add_user

		def select_user
			# TODO: write log
			Log::Write.run({action: 'Select user'})

			# TODO: Action select user
			code = Template::get_info_input{puts 'Please enter user ID'}
			data = User::login(code)
			if data
				data.each do |i|
					name  = i["name"].upcase
					code  = i["code"]
					$user = {name: name, code: code}
					puts "Hello, #{name}"
				end
				m2 = Menu2::Action.new
				m2.callback
			else
				puts 'Incorrect user ID'
				callback
			end
		end

		def show_list_user
			# TODO: write log
			Log::Write.run({action: 'Show list user'})

			# TODO: Action Show list user
			data = User::show_list_user
			if data
				data.each_with_index do |value, index|
					i = index + 1
					puts "Rows #{i} ===> ID: #{value["id"]} / Code: #{value["code"]} / Name: #{value["name"].upcase} / Money: #{value["money"]}"
				end
			else
				puts "Data was not found. Please choose add new user"
			end
			callback
		end

		def do_confirm
			c = ''
			while c != '4' do
				c = gets.chomp
				case c
				when '1' then add_user
				when '2' then select_user
				when '3' then show_list_user
				else exit
				end
			end
		end

	end # class
end # module