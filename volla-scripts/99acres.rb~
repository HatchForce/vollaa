require "rubygems"
require "mechanize"

 @timestamp = Time.now.strftime("%Y%m%d%H%M%S")
def get_properties()
 agent = Mechanize.new
 page = agent.get("http://www.99acres.com/real-estate-a-property-for-buy-sale-a-property-in-hyderabad.htm?lstAcn=CP_R&lstAcnId=38&src=BROWSEPROP")
 table = page.parser.xpath('//*[@id="results"]')
 div = table.children()[4]
 @data_container = [] 
 for x in [3,7,11,19,23]
 data = div.children()[x]
 property_type = 'residential'
 property_for = 'sale'
 city = 'hyderabad'
 state = 'andhra pradesh'
 country = 'india'
 property_title = data.children()[1].children()[7].text().split(',')[1]
 property_price = data.children()[1].children()[5].text().split('L')[0] 
 built_up_area = data.children()[3].children()[3].children().children()[1].text().split('S')[0]
 bedrooms = data.children()[1].children()[7].text().split('B')[0]
 property_age = " "
 description =  data.children()[3].children()[3].children().children()[5].text().gsub(/\s+/, " ").strip
 #property_image =  data.children()[3].children()[1].children()[1].children().children()[1].attribute('src')
 property_image = "http://imgs.indiaproperty.com/images/bsearch_listingnoimage.gif"
 last_update = Date.parse(data.children()[5].children()[7].text())
 more_link = "http://www.99acres.com" + data.children()[1].children()[7].attribute('href')

 @data_container << [property_type,property_for,city,state,country,property_title,description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,"99acres.com",more_link]
  end
File.open("99acres_#{@timestamp}.txt", 'a+') do |f|
  @data_container.each do|data| 
  # puts data
    f.puts data.join("|")
   end
  end
end
i = 1
 until i == 169
  get_properties()
  i = i + 1
end

