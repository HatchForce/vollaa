require "rubygems"
require "mechanize"

@timestamp = Time.now.strftime("%Y%m%d%H%M%S")
def get_properties(i)
 puts "####"+" "+"#{i}" +" "+"####" 
 agent = Mechanize.new
 page = agent.get("http://hyderabad.indiaproperty.com/property/hyderabad/flats.html?page=#{i}")
 @data_container = []
 for x in [0,1,2,4,5,6,7,8,9,10,11,12,13,1,4,15,16,17,18,19,20,21,22,23,24,25] 
  div = page.parser.xpath("//*[@id='IP#{x}']") 
  div_child = div.children()
  property_type = 'residential'
  property_for = 'sale'
  city = 'hyderabad'
  state = 'andhra pradesh'
  country = 'india'
  property_title = div_child.children()[1].children()[1].text()
  property_description = ' '  
  property_price = div_child.children()[1].children()[3].children()[0].text()
  built_up_area = div_child.children()[1].children()[3].children()[1].text()
  bedrooms = div_child.children()[1].children()[3].children()[3].text()
  property_age = div_child.children()[1].children()[3].children()[5].text()
  property_image = div_child.children()[0].children()[1].attributes['src']
  last_update = Date.parse(div_child.children()[1].children()[6].children()[0].children()[2].text().split(":")[1])
  more_link = "http://hyderabad.indiaproperty.com" + div_child.children()[1].children()[6].children()[0].children()[3].elements.attribute('href')
  
 @data_container << [property_type,property_for,city,state,country,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,"indiaproperty.com",more_link]
 end
 File.open("ip_hyd_2#{@timestamp}.txt", 'a+') do |f|
  @data_container.each do|data| 
  # puts data
    f.puts data.join("|")
   end
  end
end

 i = 1
 until i == 40
  get_properties(i)
  i = i + 1
 end

