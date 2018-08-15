def divide(a, b)
  a / b
end

# Tasks:
# Change the following method `tell_a_story` so that
# 1. It will output "120 cannot be divided by zero" by trapping an Exception
# 2. And make sure that it also outputs `120 divided by -1 is -120`

def tell_a_story
  (-1..5).reverse_each do |i|
    begin
      value = divide(120, i)
      puts "120 divided by #{i} is #{value}"
    rescue ZeroDivisionError
      puts "120 cannot be divided by zero"
    end
  end
  puts "X: Will this line be executed?"
end

tell_a_story
puts "Y: Will this line be executed?"
