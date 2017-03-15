module Menu2
	class Action
		MIN_AMOUNT_IN_CARD     = 50000
		MIN_TRANSACTION_AMOUNT = 10000
		def callback
			Template::show_menu_2
			do_confirm
		end

		private

		def check_money
			# TODO: write log
			Log::Write.run({action: 'Check money', user: $user[:code]})

			# TODO: Action check money
			money = User::select_money($user[:code]) 
			puts "Your current money: #{money} VND"
			callback
		end

		def withdraw_cash
			# TODO: write log
			Log::Write.run({action: 'Withdraw cash', user: $user[:code]})

			# TODO: Action withdraw_cash
			money = User::select_money($user[:code])
			puts "Your money: #{money} VND"

			amount_withdraw = Template::get_info_input{puts 'Please enter the amount withdraw:'}.to_i
			remaining = money - amount_withdraw

			if amount_withdraw < MIN_TRANSACTION_AMOUNT
				puts "The minimum transaction amount must #{MIN_TRANSACTION_AMOUNT} VND"
				callback
			end

			if amount_withdraw > money
				puts 'You not enough money'
			elsif remaining > MIN_AMOUNT_IN_CARD
				User::update_money(remaining, $user[:code])
				puts "You have successfully withdraw money", "Your current money: #{remaining}"	
			else
				puts "So tien du toi thieu phai bang #{MIN_AMOUNT_IN_CARD} VND"
			end
			callback
		end

		def add_money
			# TODO: write log
			Log::Write.run({action: 'Add money', user: $user[:code]})

			# TODO: Action add money
			money = User::select_money($user[:code])
			flat = true
			while flat do
				add_money = Template::get_info_input{puts 'Please enter the amound you need add:'}.to_i
				if add_money >= MIN_TRANSACTION_AMOUNT
					flat = true
					money = money + add_money
					User::update_money(money, $user[:code])
					puts "You have successfully add money", "Your current money: #{money}"	
					callback	
				else
					flat = true
					puts "The minimum transaction amount must #{MIN_TRANSACTION_AMOUNT} VND"
				end
			end
		end

		def remittance
			# TODO: Action remittance
			sender = $user[:code]
			current_amount_sender  = User::select_money(sender)
			puts "Your current money: #{current_amount_sender} VND"

			flat = true
			while flat do
				receiver = Template::get_info_input{puts 'Please enter code receiver'}
				if !User::select_code(receiver)
					puts 'Don\'t exist user'
					callback
				end

				amount_send = Template::get_info_input{puts 'Please enter the amound to send'}.to_i
				if amount_send < MIN_TRANSACTION_AMOUNT
					puts "The minimum transaction amount must #{MIN_TRANSACTION_AMOUNT} VND"
					callback
				end

				if amount_send > (current_amount_sender - MIN_AMOUNT_IN_CARD)
					puts "You can't not afford to make transaction"
					callback
				end
				flat = false
			end

			# Update money sender
			remaining_amount     = current_amount_sender - amount_send		
			update_amount_sender = User::update_money(remaining_amount, sender)

			# Update money receiver
			if update_amount_sender
				current_amount_receiver = User::select_money(receiver)
				amount_receiver         = current_amount_receiver + amount_send
				User::update_money(amount_receiver, receiver)
				puts "The transfer money successfully", "Your current money: #{remaining_amount}"
			else
				# Rollback money sender
				User::update_money(current_amount_sender, sender)
				puts "The transfer money failed", "Your current money: #{current_amount_sender}"
			end

			# TODO: write log
			Log::Write.run({action: 'remittance', user: $user[:code], receiver: receiver})
			callback
		end

		def come_back
			# TODO: write log
			Log::Write.run({action: 'Comeback', user: $user[:code]})
			$user = {}
			m1.callback
		end

		def do_confirm
			c = ''
			while c != '6' do
				c = gets.chomp
				case c
				when '1' then check_money
				when '2' then remittance
				when '3' then withdraw_cash
				when '4' then add_money
				when '5' then come_back
				else exit
				end
			end
		end

	end # class
end # module