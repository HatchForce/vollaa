require "rubygems"
require "mechanize"

@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(i)
  puts "#####{i}#####"
  agent = Mechanize.new
  page = agent.get("http://hyderabad.indiaproperty.com/property/greater-hyderabad.html?page=#{i}")
  @data_container = []
  x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
  x.each do |x|
    div = page.parser.xpath("//*[@id='IP#{x}']")
    div_child = div.children()
    property_type = 'Residential'
    property_for = 'sale'
    city = 'Hyderabad'
    state = 'Andhra Pradesh'
    country = 'India'
    property_title = div_child.children()[0].text() rescue ""
    property_description = div_child.children()[10].text() rescue ""
    p_p = div_child.children()[2].children()[0].children()[0].text().split(/ /) rescue ""
    price = p_p.join(" ").split("Rs.")[1].to_s rescue "0"
    p_price = price.to_f
    if price.match("Lac")
      property_price =  (p_price * 100000).to_i
    elsif price.match("Crore")
      property_price =  (p_price * 10000000).to_i
    else
      property_price = 0
    end
    built_up_area = div_child.children()[2].children()[1].children()[0].children[1].children[0].to_s.to_i rescue ""
    bedrooms = div_child.children()[2].children()[1].children()[2].children[0].text.split(":")[1] rescue "NA"
    property_age = div_child.children()[2].children()[1].children()[4].children()[0].text.split(":")[1] rescue ""
    last_update = Date.parse(div_child.children()[2].children()[2].children()[0].children()[1].children()[0].text.split(":")[1]) rescue ""
    property_image = div_child.children()[1].children()[1].children()[0].attributes['src'] rescue ""
    #last_update = Date.parse(div_child.children()[1].children()[6].children()[0].children()[2].text().split(":")[1])
    more_link = "http://hyderabad.indiaproperty.com" + div_child.children()[2].children()[2].children()[0].children()[2].children()[0].attributes['href'] rescue ""
    source = "indiaproperty.com"
    created_at = Time.now
    puts x
    @data_container << [property_type, property_for, city, state, country,property_title, property_description, property_price, built_up_area, bedrooms, property_age, last_update, property_image, source, more_link, created_at]
  end
  File.open("indianproperty_hyd_#{@timestamp}.txt", 'a+') do |f|
    @data_container.each do |data|
      #puts data
      f.puts data.join("|")
    end
  end
end

i = 1
until i == 21
  get_properties(i)
  i = i + 1
end



