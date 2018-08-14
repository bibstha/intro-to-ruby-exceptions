# Intro to Ruby - Exceptions

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

2.
```
irb(main):005:0> puts divide(5)
ArgumentError: wrong number of arguments (given 1, expected 2)
	from (irb):1:in `divide'
	from (irb):5
	from /usr/bin/irb:11:in `<main>'
```

3.
```
irb(main):007:0> puts divide("50", 2)
NoMethodError: undefined method `/' for "50":String
	from (irb):2:in `divide'
	from (irb):7
	from /usr/bin/irb:11:in `<main>'
```

Question: Can we change `def divide` so it can solve all three errors?
Answer: No.

Question: What does the output in all three situation tell us about the situation?
Answer: If you take a look at the second line in each case, it describes what went wrong:

```
ZeroDivisionError: divided by 0
ArgumentError: wrong number of arguments (given 1, expected 2)
NoMethodError: undefined method `/' for "50":String
```

In each case, you have the type of the Exception: `ZeroDivisionError`, `ArgumentError` and `NoMethodError` followed by a
detail description of the situation.

## Exceptions and control-flow

```ruby
puts "start"
puts divide(5, 2)
puts divide(5, 0)
puts "finish"
```

Question: We have three lines in the code above. Line 2 `puts divide(5, 0)` however causes an Exception. So how does the
output look like?
Answer:

```
start
2
output_during_exception.rb:2:in `/': divided by 0 (ZeroDivisionError)
	from output_during_exception.rb:2:in `divide'
	from output_during_exception.rb:7:in `<main>'
```

Notice that "finish" is missing from the output.

NOTE: **Raising an exception halts program execution.**

Question: If a program execution does not continue forward, where does it go?
Answer: A raised exception will propagate through each method in the call stack until it is stopped or reaches the point
where the program started.

Example:

`name: 2_tell_a_story.rb`
```ruby
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
```

Output

```
26 divided by 5 is 5
26 divided by 4 is 6
26 divided by 3 is 8
26 divided by 2 is 13
26 divided by 1 is 26
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
`<main> > tell_a_story > reverse_each > block in tell_a_story > divide`

## How to handle Exceptions?

Exceptions are easy to handle.

begin, rescue, end

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
  is just a class. Similarly `ZeroDivisionError`, `NoMethodError`, `ArgumentError` are all classes in Ruby.
* Notice also that you no longer see the stack trace. This means that the program did not terminate right away.

## Raising Exceptions

We saw previously how to raise an Exception: `raise Exception.new("message here")`. However to raise an exception we
normally do not create a new instance. Instead we use the syntax:

```
raise Exception, "message here"
raise StandardError, "explain what went wrong"
raise ArgumentError, "you are missing an argument"
```

```ruby
class Kenya
  def activity_in(season)
    if season == 'winter'
      raise ArgumentError, "I don't know this season"
    else
      return "Safari, Hiking, Travel, Read, Beach"
    end
  end
end

begin
  Kenya.new.activity_in("winter")
rescue ArgumentError => e
  puts "Error for Kenyan activity for winter: #{e.message}"
end
```

Output
```
Error for Kenyan activity for winter: I don't know this season
```

## References

* https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/41-exceptions/lessons/92-handling
