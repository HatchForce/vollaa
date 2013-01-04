require "rubygems"
require "mechanize"

@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(i)
  puts "####"+" "+"#{i}" +" "+"####"
  agent = Mechanize.new
  page = agent.get("http://kolkata.indiaproperty.com/property/kolkata.html?page=#{i}")
  @data_container = []
  x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
  x.each do |x|
    div = page.parser.xpath("//*[@id='IP#{x}']")
    div_child = div.children()
    property_type = 'All'
    property_for = 'sale'
    city = 'Kolkata'
    state = 'West Bengal'
    country = 'India'
    local_area = 'All'
    property_title = div_child.children()[0].text() rescue ""
    property_description = div_child.children()[10].text() rescue ""
    p_p = div_child.children()[2].children()[0].children()[0].text().split(/ /) rescue ""
    #p_p =  div_child.children()[1].children()[3].children()[0].text().split(/ /)[1].split(",")
    property_price = p_p.join() rescue ""
    built_up_area = div_child.children()[2].children()[1].children()[0].children[1].children[0] rescue ""
    bedrooms = div_child.children()[2].children()[1].children()[2].children[0].text.split(":")[1] rescue ""
    property_age = div_child.children()[2].children()[1].children()[4].children()[0].text.split(":")[1] rescue ""
    last_update = Date.parse(div_child.children()[2].children()[2].children()[0].children()[1].children()[0].text.split(":")[1]) rescue ""
    property_image = div_child.children()[1].children()[1].children()[0].attributes['src'] rescue ""
    #last_update = Date.parse(div_child.children()[1].children()[6].children()[0].children()[2].text().split(":")[1])
    more_link = "http://kolkata.indiaproperty.com" + div_child.children()[2].children()[2].children()[0].children()[2].children()[0].attributes['href'] rescue ""
    created_at = Time.now
    puts x
    #more_link = "http://hyderabad.indiaproperty.com" #+ div_child.children()[1].children()[6].children()[0].children()[3].elements.attribute('href')
    @data_container << [property_type, property_for, city, state, country, local_area, property_title, property_description, property_price, built_up_area, bedrooms, property_age, last_update, property_image, "indiaproperty.com", more_link,created_at]

    #@data_container << [property_type,property_for,city,state,country,local_area,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,"indiaproperty.com",more_link]
  end
  File.open("indianproperty_kolkata_#{@timestamp}.txt", 'a+') do |f|
    @data_container.each do |data|
      puts data
      f.puts data.join("|")
    end
  end
end

i = 1
until i == 21
  get_properties(i)
  i = i + 1
end



