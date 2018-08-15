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
