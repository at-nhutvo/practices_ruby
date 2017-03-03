class Person
	@@current_year = Time.new.year
	def initialize(years)
		@years = years
	end

	def export
		"I'm #{@@current_year - @years} years old"
	end
end

person = Person.new(1992)
puts person.export

