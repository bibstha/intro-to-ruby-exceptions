# Intro to Ruby - Exceptions

## 1. Testing out Exceptions

When something goes wrong in our code, we get Exceptions. Exceptions are a part of software development.
Example:

```ruby
def divide(a, b)
  a / b
end

irb: divide(5, 2)
> 2
```

What could go wrong with this program?

1. divide by zero `divide(5, 0)`
1. missing argument when calling divide: `divide(5)`
1. wrong type when calling divide: `divide("50", 2)`

What happens?

1.
```
irb(main):004:0> puts divide(5, 0)
ZeroDivisionError: divided by 0
	from (irb):2:in `/'
	from (irb):2:in `divide'
	from (irb):4
	from /usr/bin/irb:11:in `<main>'
```

Execute: `ruby 1_1_zero_division_error.rb`

2.
```
irb(main):005:0> puts divide(5)
ArgumentError: wrong number of arguments (given 1, expected 2)
	from (irb):1:in `divide'
	from (irb):5
	from /usr/bin/irb:11:in `<main>'
```

Execute: `ruby 1_2_argument_error.rb`

3.
```
irb(main):007:0> puts divide("50", 2)
NoMethodError: undefined method `/' for "50":String
	from (irb):2:in `divide'
	from (irb):7
	from /usr/bin/irb:11:in `<main>'
```

Execute: `ruby 1_3_no_method_error.rb`

Question: What does the output in all three situation tell us about the situation?

Answer: If you take a look at the second line in each case, it describes what went wrong:

```
ZeroDivisionError: divided by 0
ArgumentError: wrong number of arguments (given 1, expected 2)
NoMethodError: undefined method `/' for "50":String
```

In all three lines, you have the type of the Exception: `ZeroDivisionError`, `ArgumentError` and `NoMethodError`
followed by a detail description of the situation.

We will talk about the types and the messages later in this tutorial.

## 2. Exceptions and control-flow

```ruby
puts "start"
puts "5 divided by 2 = #{divide(5, 2)}"
puts "5 divided by 0 = #{divide(5, 0)}"
puts "finish"
```

Execute: `ruby 1_4_output_during_exception.rb`

Question: 

1. Which line causes an exception?
2. What happens to the lines above the exception?
3. What happens to the lines after the exception?

Answer:

```
start
5 divided by 2 = 2
1_4_output_during_exception.rb:2:in `/': divided by 0 (ZeroDivisionError)
        from 1_4_output_during_exception.rb:2:in `divide'
        from 1_4_output_during_exception.rb:7:in `<main>'
```

1. Line 3 with `divide(5, 0)` caused the exception.
2. Lines 1 and 2 were executed successfully.
3. Line 4 wasn't executed at all.

NOTE: **Raising an exception halts program execution.**

Question: If a program execution does not continue forward, where does it go?

Answer: A raised exception will propagate through each method in the call stack until it is stopped or reaches the point
where the program started.

Example:

```ruby
def divide(a, b)
  a / b
end

def tell_a_story
  (-1..5).reverse_each do |i|
    value = divide(120, i)
    puts "120 divided by #{i} is #{value}"
  end
  puts "X: Will this line be executed?"
end

tell_a_story
puts "Y: Will this line be executed?"
```

Execute `ruby 2_tell_a_story.rb`

Output

```
120 divided by 5 is 24
120 divided by 4 is 30
120 divided by 3 is 40
120 divided by 2 is 60
120 divided by 1 is 120
2_tell_a_story.rb:2:in `/': divided by 0 (ZeroDivisionError)
        from 2_tell_a_story.rb:2:in `divide'
        from 2_tell_a_story.rb:7:in `block in tell_a_story'
        from 2_tell_a_story.rb:6:in `reverse_each'
        from 2_tell_a_story.rb:6:in `tell_a_story'
        from 2_tell_a_story.rb:12:in `<main>'
```

* Notice above how it does not divide for `-1`.
* Notice in the output above how it gives the exact line where the exception happened.
* Notice how it also shows the way our code was executed:
`<main> → tell_a_story → reverse_each → block in tell_a_story → divide`
* Notice that non of the two lines `puts "X|Y: Will this line be executed?" execute.

## 3. How to handle Exceptions?

Exceptions are easy to handle.

**begin, rescue, end**

```ruby
def start_summer
  raise Exception.new("overheated!")
end

begin
  start_summer
rescue Exception
  puts "It's cool in here, boy. For the rest of the summer, we'll live in the refrigerator."
end
```

Output
```
It's cool in here, boy. For the rest of the summer, we'll live in the refrigerator.
```

* Notice we raised an Exception ourselves with `Exception.new("overheated!")`. Exceptions like everything else in Ruby
  are just classes. Similarly `ZeroDivisionError`, `NoMethodError`, `ArgumentError` are all classes in Ruby.
* Notice also that you no longer see the stack trace. This means that the program did not get terminated unexpectedly.

## 4. Raising Exceptions

We saw previously how to raise an Exception: `raise Exception.new("message here")`. However to raise an exception we
normally do not create a new instance. Instead we use the syntax:

```
raise Exception, "message here"
raise StandardError, "explain what went wrong"
raise ArgumentError, "you are missing an argument"
```

```ruby
class Kenya
  def activities_in(season)
    if season == 'winter'
      raise ArgumentError, "I don't know this season called '#{season}'"
    else
      return "Safari, Hiking, Travel, Read, Beach"
    end
  end
end

begin
  kenya = Kenya.new
  puts "Summer Activities in Kenya: #{kenya.activities_in("summer")}"
  puts "Winter Actibities in Kenya: #{kenya.activities_in("winter")}"
rescue ArgumentError => e
  puts e.message
end
```

Output
```
Summer Activities in Kenya: Safari, Hiking, Travel, Read, Beach
I don't know this season called 'winter'
```

## 5. Breakout session

Three small exercises inside folder `break_out_session`.

1. `ruby 1_print_cannot_divide_by_zero.rb`
2. `ruby 2_first_rescue.rb`
3. `ruby 3_raise_exceptions.rb`

## References

* https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/41-exceptions/lessons/92-handling
