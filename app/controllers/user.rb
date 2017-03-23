require_relative "../models/user.rb"
require 'pry'
class UserController
	def call(env)
		@request = Rack::Request.new(env)
		routing(@request.path)
	end

	def routing(path)
		case path
		when '/user' then list_view
		when '/user/add' then add
		when '/user/edit' then edit
		when '/user/delete' then delete
		else not_found
		end
	end

	def list_view
		@data = User::select_list_user ? User::select_list_user : {}
		@title = 'List user'
		template = File.read('app/views/users/list.html.erb')
		result = ERB.new(template).result(binding)
		Rack::Response.new(result)
	end

	def add
		if @request.post?
			if User::add_user(@request.params["name"])
				redirect_to('user')
			end
		else
			@title = 'Add user'
			template = File.read('app/views/users/add.html.erb')
			result = ERB.new(template).result(binding)
			Rack::Response.new(result)
		end
	end

	def edit
		if @request.post?
			id = @request.params["id"]
			name = @request.params["name"]
			money = @request.params["money"]
			if User::update_user(id, {name: name, money: money})
				redirect_to('user')
			else
				result = "Update failed"
				Rack::Response.new(result)
			end
		else
			id = @request.params["id"]
			@data = User::select_a_user(id)
			@title = 'Edit user'
			template = File.read('app/views/users/edit.html.erb')
			result = ERB.new(template).result(binding)
			Rack::Response.new(result)
		end
	end

	def delete
		id = @request.params["id"]
		if User::delete_user(id)
			redirect_to('user')
		else
			result = "Couldn't delete user"
			Rack::Response.new(result)
		end
	end

	def not_found
		Rack::Response.new('Not found', 404)
	end

	def redirect_to(page = 'user')
		res = Rack::Response.new
		res.redirect("/#{page}")
		res.finish
	end
end