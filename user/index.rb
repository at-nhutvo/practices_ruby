# Setup
require 'csv'
require_relative "core/DB"
require_relative "config/config"
require_relative "module/handle_error"
require_relative "module/read_file"
require_relative "controller/user_controller"

# Execute
source = Dir.pwd << '/data_master.txt'

user = UserController.new
user.set_source('./data_master.txt')
puts user.run
