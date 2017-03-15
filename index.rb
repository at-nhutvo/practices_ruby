# Setup
require_relative "core/DB"
require_relative "config/config"
require_relative "module/template"
require_relative "model/user"
require_relative "controller/atm_controller"

atm = ATMController.new
atm.run