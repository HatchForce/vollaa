require "rubygems"
require "mechanize"


@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(i,p)
 agent = Mechanize.new
 page = agent.get("http://www.makaan.com/bangalore-property/residential-property-for-sale-in-bangalore/search-properties/?rest=0&start=#{p}&title=&after=&pg_searchresults_id=e28a0819f5e72d6d42d0c863a5dc93a9&sort=&sorttype=&mid=")
 table = page.parser.xpath('//table[@class="ppsearch"]')

 @data_container = []
 #x = [2,5,9,13,14,15,16,18,19,24]
 x = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
 x.each do |x|
 puts "####"+" "+"#{i}" +" "+"####"
 td = table[2].children()[1]  rescue ''
 data = td.children()[0].children()[0].children()[6].children()[1] rescue ''
 property_type = 'residential'
 property_for = 'sale'
 city = 'chennai'
 state = 'tamilnadu'
 country = 'india'
 property_title = data.children()[3].children()[1].text() + data.children()[3].children()[3].text() rescue ''
 description = data.children()[3].children()[11].text().split('.')[0] + data.children()[3].children()[11].text().split('.')[1].chop!  rescue ''
 property_description = description.gsub(/\s+/, " ").strip  rescue ''
 p_p = data.children()[3].children()[5].text() rescue ''
 p_pr = p_p.split('.')[1].split('/')[0].split(',') rescue ''
 property_price = p_pr.join()  rescue ''
 b = data.children()[3].children()[7].text().gsub(/\s+/, " ").strip rescue ''
 b_u_a = b.split('|')[1].split(/ /)[0].split('S')[0].split(',') rescue ''
 built_up_area = b_u_a.join()  rescue ''
 bedrooms = b.split('|')[0].split('B')[0]  rescue ''
 property_age = b.split('|')[3] rescue ''
 #img = data.children()[5].children()[5].children()[1].elements[1].elements[0]
 property_image = "http://imgs.indiaproperty.com/images/bsearch_listingnoimage.gif"
 last_update = Date.parse(data.children()[5].children()[1].text()) rescue ''
 more_link = data.children()[3].children()[1].children().attribute('href')  rescue ''

 @data_container << [property_type,property_for,city,state,country,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,"indiaproperty.com",more_link]
 end
File.open("makaan_#{@timestamp}.txt", 'a+') do |f|
  @data_container.each do|data|
   puts data
    f.puts data.join("|")
   end
  end
end
i = 1
 until i == 82
   (i == 1)? p = 1 : p = p.to_i + 25
  get_properties(i,p)
  i = i + 1
end

