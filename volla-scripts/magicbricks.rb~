require "rubygems"
require "mechanize"

@timestamp = Time.now.strftime("%Y%m%d%H%M%S")
def get_properties(i)
 agent = Mechanize.new
 page = agent.get("http://www.magicbricks.com/property-for-sale/Multistorey-Apartment-real-estate-Hyderabad")
 div_array = page.parser.xpath('//*[@id="propSearchMainWrap"]')
 @data_container = [] 
 for x in [1,2,3,4,5,6,7,8,9,10,11,14,15,18,19,20,21]
 property_type = 'residential'
 property_for = 'sale'
 city = 'hyderabad'
 state = 'andhra pradesh'
 country = 'india' 
 property_title = div_array[x].children()[1].children()[1].text().gsub(/\s+/, " ").strip
 div = div_array[x].children()[1].children()[3]
 price = div.children().children().children()[5].children()[3].children()[1].text().gsub(/\s+/, " ").strip
 property_description  = div.children()[3].children()[3].text().split('.')[0].gsub(/\s+/, " ").strip
 property_price = price.split(/ /)[2].to_f * 100000 
 content = div.children().children().children()[11].children().children().children()
 built_up_area = content.children()[5].text().split(/ /)[0]
 bedrooms = content.children()[1].text()
 property_age = " "
 property_image =  "http://imgs.indiaproperty.com/images/bsearch_listingnoimage.gif"
 last_update = Date.parse(div.children()[9].children()[3].text().split('|')[1].gsub(/\s+/, " ").strip.split('V')[0])
 more_link = "http://www.magicbricks.com" + div.children()[3].children()[3].elements[1].attribute('href')

@data_container << [property_type,property_for,city,state,country,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,"magicbricks.com",more_link]
 end
File.open("magicbrick_#{@timestamp}.txt", 'a+') do |f|
  @data_container.each do|data| 
   #puts data
    f.puts data.join("|")
   end
  end
end
i = 1
 until i == 18
  get_properties(i)
  i = i + 1
end

