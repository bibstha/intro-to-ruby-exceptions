def divide(a, b)
  a / b
end

def tell_a_story
  (-1..5).reverse_each do |i|
    value = divide(26, i)
    puts "26 divided by #{i} is #{value}"
  end
end

tell_a_story
