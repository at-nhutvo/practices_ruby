class Person
	def initialize(name, age)
		@name = name
		@age = age
	end

	def export
		puts "My name is #{@name}, I'm #{@age} years old"
	end
end

person = Person.new("Minh", "25")
person.export