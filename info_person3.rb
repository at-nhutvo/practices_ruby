puts "How old are you?"
input = gets.chomp
current_year = Time.new.year
year_old = current_year - input.to_i
# input.empty? ? year_old : " "
if (input.empty?)
	puts year_old
else
	puts "Error"
end
