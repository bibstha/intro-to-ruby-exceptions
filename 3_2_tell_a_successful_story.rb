def divide(a, b)
  a / b
end

def tell_a_story
  (-1..5).reverse_each do |i|
    begin
      value = divide(120, i)
      puts "120 divided by #{i} is #{value}"
    rescue ZeroDivisionError
      puts "120 cannot be divided by 0"
    end
  end
  puts "X: Will this line be executed?"
end

tell_a_story
puts "Y: Will this line be executed?"
