require "rubygems"
require "mechanize"

@timestamp = Time.now.strftime("%Y%m%d%H%M%S")
def get_properties(i)
  puts "####"+" "+"#{i}" +" "+"####"
 agent = Mechanize.new
 page = agent.get("http://www.magicbricks.com/property-for-sale/Multistorey-Apartment-real-estate-Mumbai#!page=#{i}")
 div_array = page.parser.xpath('//*[@class="individualWrapper"]')
 @data_container = [] 
 x = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]
 x.each do |x|
 property_type = 'residential'
 property_for = 'sale'
 city = 'mumbai'
 state = 'andhra pradesh'
 country = 'india'
 local_area = "Mumbai All"
 property_title = div_array[x].children()[1].children()[1].children()[1].children()[1].children()[4].children()[1].children()[0] rescue " "
 div = div_array[x].children()[1].children()[1]
 property_price = div.children()[3].children[3].children[1].children[5].children[3].children[1].children[0].text.split(/:/)[1].split(/Rs./)[1] rescue ""
 property_description = div.children()[3].children[3].children[3].children[1].children[0] rescue ""
 built_up_area =  div.children()[3].children[3].children[1].children[11].children[1].children[1].children[6].children[1].children[0] rescue ""
 bedrooms = div.children()[3].children[3].children[1].children[11].children[1].children[1].children[2].children[1].children[0] rescue ""
 property_age = " "
 image = div.children()[3].children[9].children[1].children[0].children[0].attributes['src'] rescue ""
 property_image =  "http://www.magicbricks.com" + image rescue ""
 last_update = ''
 link = div.children()[3].children[9].children[1].children[3].attributes['href'].text.split(/==/)[0] rescue ''
 more_link = link.empty?? ("http://www.magicbricks.com" + link) : ''
  puts x
 @data_container << [property_type,property_for,city,state,country,local_area,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,"magicbricks.com",more_link]
 end
File.open("magicbrick_Multistorey_Apartment_Mumbai#{@timestamp}.txt", 'a+') do |f|
  @data_container.each do|data|
   #puts data
    f.puts data.join("|")
   end
  end
end
i = 1
 until (i == 16)
  get_properties(i)
  i = i + 1
end

