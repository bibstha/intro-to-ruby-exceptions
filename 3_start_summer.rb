def start_summer
  raise Exception.new("overheated!")
end

begin
  start_summer
rescue Exception
  puts "It's cool in here, boy. For the rest of the summer, we'll live in the refrigerator."
end
