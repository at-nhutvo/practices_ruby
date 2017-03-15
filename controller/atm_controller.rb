require_relative '../module/menu_1'
require_relative '../module/menu_2'
require_relative '../module/log'
class ATMController
	$user = {}
	def run
		# TODO : Write log
		Log::Write.new

		# TODO: Show menu
		m1 = Menu1::Action.new
		m1.callback
	end
end # Class