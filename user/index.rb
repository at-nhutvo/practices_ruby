# Setup
require 'csv'
require_relative "core/DB"
require_relative "config/config"
require_relative "module/read_file"
require_relative "controller/user_controller"

UserController.new.run
