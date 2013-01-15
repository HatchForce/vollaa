require "rubygems"
require "mechanize"


@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(i)
 agent = Mechanize.new
 page = agent.get("http://www.makaan.com/property/omr-flats")
 table = page.parser.xpath('//table[@class="ppsearch"]')
 @data_container = []
for x in [1,3,4,10,12,17,20,22,23,25] 
 td = table[3].children()[1]
 data = td.children()[0].children()[0].children()[6].children()[1]
 property_type = 'residential'
 property_for = 'sale'
 city = 'chennai'
 state = 'tamilnadu'
 country = 'india'
 property_title = data.children()[3].children()[1].text() + data.children()[3].children()[3].text()
 p_p = data.children()[3].children()[5].text()
 p_pr = p_p.split('.')[1].split('/')[0].split(',')
 property_price = p_pr.join()
 b = data.children()[3].children()[5].children()[3].text()
 b_u_a = b.split('|')[1].split(/ /)[0].split('S')[0].split(',')
 built_up_area = b_u_a.join()
 bedrooms = b.split('|')[0].split('B')[0]
 property_age = b.split('|')[3]
 property_description = data.children()[3].children()[9].text().split('>')
 #img = data.children()[5].children()[5].children()[0].elements.attribute('onclick').text().split("(")[1].split(',')[0].chop!
 #img_length = img.size
# property_image = "www.makaan.com" + img.slice(1..img_length)
 property_image = "http://imgs.indiaproperty.com/images/bsearch_listingnoimage.gif"	
 last_update = Date.parse(data.children()[5].children()[1].text())
 more_link = data.children()[3].children()[1].elements.attribute('href')	

 @data_container << [property_type,property_for,city,state,country,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,"makaan.com",more_link]
end
File.open("makan_#{@timestamp}.txt", 'a+') do |f|
  @data_container.each do|data| 
   #puts data
    f.puts data.join("|")
   end
  end
end
i = 1
 until i == 7
  get_properties(i)
  i = i + 1
end

