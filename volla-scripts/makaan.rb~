require "rubygems"
require "mechanize"


@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(i)
 agent = Mechanize.new
 page = agent.get("http://www.makaan.com/property/omr-flats")
 table = page.parser.xpath('//table[@class="ppsearch"]')
 @data_container = []
for x in [2,5,9,13,14,15,16,18,19,24] 
 td = table[2].children()[1]
 data = td.children()[0].children()[0].children()[6].children()[1]
 property_type = 'residential'
 property_for = 'sale'
 city = 'chennai'
 state = 'tamilnadu'
 country = 'india'
 property_title = data.children()[3].children()[1].text() + data.children()[3].children()[3].text()
 description = data.children()[3].children()[11].text().split('.')[0] + data.children()[3].children()[11].text().split('.')[1].chop! 
 property_description = description.gsub(/\s+/, " ").strip
 p_p = data.children()[3].children()[5].text()
 p_pr = p_p.split('.')[1].split('/')[0].split(',')
 property_price = p_pr.join()
 b = data.children()[3].children()[7].text().gsub(/\s+/, " ").strip
 b_u_a = b.split('|')[1].split(/ /)[0].split('S')[0].split(',')
 built_up_area = b_u_a.join()
 bedrooms = b.split('|')[0].split('B')[0]
 property_age = b.split('|')[3]
 #img = data.children()[5].children()[5].children()[1].elements[1].elements[0]
 property_image = "http://imgs.indiaproperty.com/images/bsearch_listingnoimage.gif"
 last_update = Date.parse(data.children()[5].children()[1].text())
 more_link = data.children()[3].children()[1].children().attribute('href')
 
 @data_container << [property_type,property_for,city,state,country,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,"indiaproperty.com",more_link]
 end
File.open("makaan_#{@timestamp}.txt", 'a+') do |f|
  @data_container.each do|data| 
  # puts data
    f.puts data.join("|")
   end
  end
end
i = 1
 until i == 7
  get_properties(i)
  i = i + 1
end

