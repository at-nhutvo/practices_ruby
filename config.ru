require 'erb'
require_relative 'core/config'
require_relative 'environment'
use Rack::Reloader, 0
use Rack::ContentType
use Rack::Static, urls:["/css"], root: "public"

map '/' do
	run HomeController.new
end

map '/user' do
	run UserController.new
end